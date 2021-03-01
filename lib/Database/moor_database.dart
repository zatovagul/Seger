import 'dart:math';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart';
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
  TextColumn get info => text()();
  BoolColumn get def => boolean().withDefault(const Constant(false))();
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
  DateTimeColumn get date => dateTime()();
  IntColumn get folderId =>
      integer().customConstraint("REFERENCES folders(id)")();
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

  Stream<List<Mat>> watchMats() => select(mats).watch();
  Stream<List<Mat>> watchMatsOrdered() => (select(mats)..orderBy([
    (t)=>OrderingTerm(expression: t.name)
  ])).watch();
  Future<List<Mat>> getAllMats() => select(mats).get();
  Future deleteAllMats() => delete(mats).go();
}

@UseDao(tables: [MatOxides, Mats, Oxides])
class MatOxideDao extends DatabaseAccessor<AppDatabase>
    with _$MatOxideDaoMixin {
  final AppDatabase db;
  MatOxideDao(this.db) : super(db);

  Stream<List<MatOxide>> watchMatOxidesByMatId(int matId) =>
      (select(matOxides)..where((tbl) => tbl.matId.equals(matId))).watch();
  Stream<List<MatOxide>> watchMatOxides() => select(matOxides).watch();
  Future<List<MatOxide>> getAllMatOxides() => select(matOxides).get();
  Future<List<MatOxide>> getMatOxidesByMatId(int matId) => (select(matOxides)..where((tbl) => tbl.matId.equals(matId))).get();
  Future insertNewMaterialOxide(MatOxide matOxide) =>
      into(matOxides).insert(matOxide);
  Future insertAllMaterialOxides(List<MatOxide> matOxide) =>
      into(matOxides).insertAll(matOxide);
  Future deleteMaterialOxide(MatOxide matOxide) =>
      delete(matOxides).delete(matOxide);
  Future deleteAllMaterialOxides() => delete(matOxides).go();
}

@UseDao(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;
  RecipeDao(this.db) : super(db);

  Stream<List<Recipe>> watchRecipesByFolderId(int folderId) =>
      (select(recipes)..where((tbl) => tbl.folderId.equals(folderId))).watch();
  Future insertRecipe(Recipe recipe) => into(recipes).insert(recipe);
  Future updateRecipe(Recipe recipe) => update(recipes).replace(recipe);
}

@UseDao(tables: [RecipeMats])
class RecipeMatDao extends DatabaseAccessor<AppDatabase>
    with _$RecipeMatDaoMixin {
  final AppDatabase db;
  RecipeMatDao(this.db) : super(db);

  Stream<List<RecipeMat>> watchRecipeMatsByRecipeId(int recipeId) =>
      (select(recipeMats)..where((tbl) => tbl.recipeId.equals(recipeId)))
          .watch();
  Future insertRecipeMat(RecipeMat recipeMat) =>
      into(recipeMats).insert(recipeMat);
  Future updateRecipeMat(RecipeMat recipeMat) =>
      update(recipeMats).replace(recipeMat);
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

@UseMoor(
    tables: [Oxides, Mats, MatOxides, Recipes, RecipeMats, Folders],
    daos: [OxideDao, MatDao, MatOxideDao, FolderDao, RecipeDao, RecipeMatDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: "db.sqlite",
          logStatements: true,
        ));
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen: (db, details) async {
        if (details.wasCreated) {
          DataInfo dataInfo = DataInfo();
          await into(oxides).insertAll(dataInfo.oxides);
          await into(mats).insertAll(dataInfo.mats);
          await into(matOxides).insertAll(dataInfo.matOxides);
          await into(folders).insertAll(dataInfo.folders);
        }
        await db.customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (migration, from, to) async {});
}
