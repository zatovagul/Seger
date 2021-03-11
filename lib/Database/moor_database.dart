import 'dart:io';
import 'dart:math';

import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:seger/Database/default_data.dart';
part 'moor_database.g.dart';

class Oxides extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get role => text()();
  TextColumn get defRole => text()();
  RealColumn get mass => real()();
}

class Mats extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get lowerName => text()();
  TextColumn get info => text()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  BoolColumn get def => boolean().withDefault(const Constant(false))();
  DateTimeColumn get date => dateTime().nullable()();
}

class MatOxides extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get oxideId =>
      integer().customConstraint("REFERENCES oxides(id)")();
  IntColumn get matId =>
      integer().customConstraint("NOT NULL REFERENCES mats(id)")();
  RealColumn get count => real()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime().nullable()();
  IntColumn get folderId =>
      integer().nullable().customConstraint("NULLABLE REFERENCES folders(id)")();
  TextColumn get image => text().nullable()();
}

class RecipeMats extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get matId =>
      integer().customConstraint("NOT NULL REFERENCES mats(id)")();
  IntColumn get recipeId =>
      integer().customConstraint("REFERENCES recipes(id)")();
  RealColumn get count => real()();
  BoolColumn get tag => boolean().withDefault(const Constant(false))();
}

class Folders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get del => boolean()();
}

@UseDao(tables: [Oxides])
class OxideDao extends DatabaseAccessor<AppDatabase> with _$OxideDaoMixin {
  final AppDatabase db;

  OxideDao(this.db) : super(db);

  Stream<Oxide> watchOxideById(int id) =>
      (select(oxides)..where((tbl) => tbl.id.equals(id))).watchSingle();
  Future<List<Oxide>> getAllOxides() => select(oxides).get();
  Stream<List<Oxide>> watchOxides() => select(oxides).watch();
  Future insertNewOxide(Oxide oxide) => into(oxides).insert(oxide);
  Future updateOxide(Oxide oxide) => update(oxides).replace(oxide);
}

@UseDao(tables: [Mats])
class MatDao extends DatabaseAccessor<AppDatabase> with _$MatDaoMixin {
  final AppDatabase db;
  MatDao(this.db) : super(db);

  Future insertNewMat(Mat mat) => into(mats).insert(mat);

  Stream<Mat> watchMatByMatId(int matId) =>
      (select(mats)..where((tbl) => tbl.id.equals(matId))).watchSingle();
  Stream<List<Mat>> watchMats() => select(mats).watch();
  Stream<List<Mat>> watchMatsOrdered() =>
        (select(mats)..orderBy([(t) => OrderingTerm(expression: t.lowerName, mode: OrderingMode.asc)]))
            .watch();

  Future<List<Mat>> getMatsOrderedByCount() => (select(mats)..orderBy([ (t)=> OrderingTerm(expression: t.count, mode: OrderingMode.desc)])).get();
  Future<List<Mat>> getAllMats() => select(mats).get();
  Future<Mat> getMatById(int matId) => (select(mats)..where((tbl) => tbl.id.equals(matId))).getSingle();
  Future updateMat(Mat mat) => update(mats).replace(mat);
  Future deleteAllMats() => delete(mats).go();
  Future deleteMat(Mat mat) => delete(mats).delete(mat);
}

@UseDao(tables: [MatOxides, Mats, Oxides])
class MatOxideDao extends DatabaseAccessor<AppDatabase>
    with _$MatOxideDaoMixin {
  final AppDatabase db;
  MatOxideDao(this.db) : super(db);

  Stream<List<MatOxideForm>> watchMatOxideFormsByMatId(int matId) =>
      ((select(matOxides)..where((tbl) => tbl.matId.equals(matId)))
              .join([leftOuterJoin(oxides, matOxides.id.equalsExp(oxides.id))]))
          .watch()
          .map((rows) => rows.map((row) {
                return MatOxideForm(
                    matOxide: row.readTable(matOxides),
                    oxide: row.readTable(oxides));
              }));
  Stream<List<MatOxide>> watchMatOxidesByMatId(int matId) =>
      (select(matOxides)..where((tbl) => tbl.matId.equals(matId))).watch();
  Stream<List<MatOxide>> watchMatOxides() => select(matOxides).watch();

  Future<List<MatOxide>> getAllMatOxides() => select(matOxides).get();
  Future<List<MatOxide>> getMatOxidesByMatId(int matId) =>
      (select(matOxides)..where((tbl) => tbl.matId.equals(matId))).get();

  Future insertNewMaterialOxide(MatOxide matOxide) =>
      into(matOxides).insert(matOxide);
  Future insertAllMaterialOxides(List<MatOxide> matOxide) =>batch((b) => b.insertAll(matOxides, matOxide));

  Future deleteMaterialOxide(MatOxide matOxide) =>
      delete(matOxides).delete(matOxide);
  Future deleteAllMaterialOxides() => delete(matOxides).go();
  Future deleteMaterialOxidesByMatId(int matId) =>
      (delete(matOxides)..where((tbl) => tbl.matId.equals(matId))).go();
}

@UseDao(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;
  RecipeDao(this.db) : super(db);

  Stream<List<Recipe>> watchRecipesByFolderId(int folderId) =>
      (select(recipes)..where((tbl) => tbl.folderId.equals(folderId))).watch();

  Future<List<Recipe>> getRecipesByFolderId(int folderId) => (select(recipes)..where((tbl) => tbl.folderId.equals(folderId))).get();
  Future<Recipe> getRecipeById(int recipeId) => (select(recipes)..where((tbl) => tbl.id.equals(recipeId))).getSingle();
  Future<List<Recipe>> getAllRecipes() => select(recipes).get();

  Future insertRecipe(Recipe recipe) => into(recipes).insert(recipe);

  Future updateRecipe(Recipe recipe) => update(recipes).replace(recipe);

  Future deleteRecipe(Recipe recipe) => delete(recipes).delete(recipe);
  Future deleteAllRecipes() => delete(recipes).go();
  Future deleteAllRecipesByFolderId(int folderId) => (delete(recipes)..where((tbl) => tbl.folderId.equals(folderId))).go();
}

@UseDao(tables: [RecipeMats])
class RecipeMatDao extends DatabaseAccessor<AppDatabase>
    with _$RecipeMatDaoMixin {
  final AppDatabase db;
  RecipeMatDao(this.db) : super(db);

  Stream<List<RecipeMat>> watchRecipeMatsByRecipeId(int recipeId) =>
      (select(recipeMats)..where((tbl) => tbl.recipeId.equals(recipeId)))
          .watch();
  Future<List<RecipeMat>> getRecipeMatsByRecipeId(int recipeId) =>
      (select(recipeMats)..where((tbl) => tbl.recipeId.equals(recipeId)))
          .get();
  Future<List<RecipeMat>> getRecipeMatsByMatId(int matId) =>
      (select(recipeMats)..where((tbl) => tbl.matId.equals(matId)))
          .get();
  Future insertRecipeMat(RecipeMat recipeMat) =>
      into(recipeMats).insert(recipeMat);
  Future insertAllRecipeMats(List<RecipeMat> recipeMat) => batch((b) => b.insertAll(recipeMats, recipeMat));
  Future updateRecipeMat(RecipeMat recipeMat) =>
      update(recipeMats).replace(recipeMat);
  Future deleteAllRecipeMats() => delete(recipeMats).go();
  Future deleteAllRecipeMatsByRecipeId(int recipeId) => (delete(recipeMats)..where((tbl) => tbl.recipeId.equals(recipeId))).go();
}

@UseDao(tables: [Folders])
class FolderDao extends DatabaseAccessor<AppDatabase> with _$FolderDaoMixin {
  final AppDatabase db;
  FolderDao(this.db) : super(db);

  Stream<List<Folder>> watchFolders() => select(folders).watch();
  Future insertFolder(Folder folder) => into(folders).insert(folder);
  Future deleteFolder(Folder folder) => delete(folders).delete(folder);
  Future updateFolder(Folder folder) => update(folders).replace(folder);
}

class MatOxideForm {
  final MatOxide matOxide;
  final Oxide oxide;
  MatOxideForm({@required this.matOxide, @required this.oxide});
}



@UseMoor(
    tables: [Oxides, Mats, MatOxides, Recipes, RecipeMats, Folders],
    daos: [OxideDao, MatDao, MatOxideDao, FolderDao, RecipeDao, RecipeMatDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(LazyDatabase(() async{
    final dbFolder=await getApplicationDocumentsDirectory();
    final file=File(p.join(dbFolder.path, 'myDB.sqlite'));
    return VmDatabase(file);
  }));
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen:  (details) async {
      if (details.wasCreated) {
          DataInfo dataInfo = DataInfo();
          await batch((b) => b.insertAll(oxides,dataInfo.oxides ));
          await batch((b) => b.insertAll(mats,dataInfo.mats ));
          await batch((b) => b.insertAll(matOxides,dataInfo.matOxides ));
          await batch((b) => b.insertAll(folders,dataInfo.folders ));
          await into(recipes).insert(dataInfo.recipe);
      }
      await customStatement("PRAGMA foreign_keys = ON");
  //await db.customStatement('PRAGMA foreign_keys = ON');
  },
      onUpgrade: (migration, from, to) async {});
}
//  sqflite: ^1.3.2+3 -> ^2.0.0+2
//   moor_flutter: ^1.6.0 -> ^4.0.0-nullsafety