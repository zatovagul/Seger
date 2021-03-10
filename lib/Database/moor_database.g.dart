// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Oxide extends DataClass implements Insertable<Oxide> {
  final int id;
  final String name;
  final String role;
  final String defRole;
  final double mass;
  Oxide(
      {@required this.id,
      @required this.name,
      @required this.role,
      @required this.defRole,
      @required this.mass});
  factory Oxide.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Oxide(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      role: stringType.mapFromDatabaseResponse(data['${effectivePrefix}role']),
      defRole: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}def_role']),
      mass: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}mass']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || defRole != null) {
      map['def_role'] = Variable<String>(defRole);
    }
    if (!nullToAbsent || mass != null) {
      map['mass'] = Variable<double>(mass);
    }
    return map;
  }

  OxidesCompanion toCompanion(bool nullToAbsent) {
    return OxidesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      defRole: defRole == null && nullToAbsent
          ? const Value.absent()
          : Value(defRole),
      mass: mass == null && nullToAbsent ? const Value.absent() : Value(mass),
    );
  }

  factory Oxide.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Oxide(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      defRole: serializer.fromJson<String>(json['defRole']),
      mass: serializer.fromJson<double>(json['mass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'defRole': serializer.toJson<String>(defRole),
      'mass': serializer.toJson<double>(mass),
    };
  }

  Oxide copyWith(
          {int id, String name, String role, String defRole, double mass}) =>
      Oxide(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        defRole: defRole ?? this.defRole,
        mass: mass ?? this.mass,
      );
  @override
  String toString() {
    return (StringBuffer('Oxide(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('defRole: $defRole, ')
          ..write('mass: $mass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(role.hashCode, $mrjc(defRole.hashCode, mass.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Oxide &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.defRole == this.defRole &&
          other.mass == this.mass);
}

class OxidesCompanion extends UpdateCompanion<Oxide> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String> defRole;
  final Value<double> mass;
  const OxidesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.defRole = const Value.absent(),
    this.mass = const Value.absent(),
  });
  OxidesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String role,
    @required String defRole,
    @required double mass,
  })  : name = Value(name),
        role = Value(role),
        defRole = Value(defRole),
        mass = Value(mass);
  static Insertable<Oxide> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> role,
    Expression<String> defRole,
    Expression<double> mass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (defRole != null) 'def_role': defRole,
      if (mass != null) 'mass': mass,
    });
  }

  OxidesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> role,
      Value<String> defRole,
      Value<double> mass}) {
    return OxidesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      defRole: defRole ?? this.defRole,
      mass: mass ?? this.mass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (defRole.present) {
      map['def_role'] = Variable<String>(defRole.value);
    }
    if (mass.present) {
      map['mass'] = Variable<double>(mass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OxidesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('defRole: $defRole, ')
          ..write('mass: $mass')
          ..write(')'))
        .toString();
  }
}

class $OxidesTable extends Oxides with TableInfo<$OxidesTable, Oxide> {
  final GeneratedDatabase _db;
  final String _alias;
  $OxidesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roleMeta = const VerificationMeta('role');
  GeneratedTextColumn _role;
  @override
  GeneratedTextColumn get role => _role ??= _constructRole();
  GeneratedTextColumn _constructRole() {
    return GeneratedTextColumn(
      'role',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defRoleMeta = const VerificationMeta('defRole');
  GeneratedTextColumn _defRole;
  @override
  GeneratedTextColumn get defRole => _defRole ??= _constructDefRole();
  GeneratedTextColumn _constructDefRole() {
    return GeneratedTextColumn(
      'def_role',
      $tableName,
      false,
    );
  }

  final VerificationMeta _massMeta = const VerificationMeta('mass');
  GeneratedRealColumn _mass;
  @override
  GeneratedRealColumn get mass => _mass ??= _constructMass();
  GeneratedRealColumn _constructMass() {
    return GeneratedRealColumn(
      'mass',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, role, defRole, mass];
  @override
  $OxidesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'oxides';
  @override
  final String actualTableName = 'oxides';
  @override
  VerificationContext validateIntegrity(Insertable<Oxide> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role'], _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('def_role')) {
      context.handle(_defRoleMeta,
          defRole.isAcceptableOrUnknown(data['def_role'], _defRoleMeta));
    } else if (isInserting) {
      context.missing(_defRoleMeta);
    }
    if (data.containsKey('mass')) {
      context.handle(
          _massMeta, mass.isAcceptableOrUnknown(data['mass'], _massMeta));
    } else if (isInserting) {
      context.missing(_massMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Oxide map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Oxide.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OxidesTable createAlias(String alias) {
    return $OxidesTable(_db, alias);
  }
}

class Mat extends DataClass implements Insertable<Mat> {
  final int id;
  final String name;
  final String lowerName;
  final String info;
  final int count;
  final bool def;
  final DateTime date;
  Mat(
      {@required this.id,
      @required this.name,
      @required this.lowerName,
      @required this.info,
      @required this.count,
      @required this.def,
      this.date});
  factory Mat.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Mat(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      lowerName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}lower_name']),
      info: stringType.mapFromDatabaseResponse(data['${effectivePrefix}info']),
      count: intType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
      def: boolType.mapFromDatabaseResponse(data['${effectivePrefix}def']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || lowerName != null) {
      map['lower_name'] = Variable<String>(lowerName);
    }
    if (!nullToAbsent || info != null) {
      map['info'] = Variable<String>(info);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || def != null) {
      map['def'] = Variable<bool>(def);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  MatsCompanion toCompanion(bool nullToAbsent) {
    return MatsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      lowerName: lowerName == null && nullToAbsent
          ? const Value.absent()
          : Value(lowerName),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      def: def == null && nullToAbsent ? const Value.absent() : Value(def),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Mat.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Mat(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lowerName: serializer.fromJson<String>(json['lowerName']),
      info: serializer.fromJson<String>(json['info']),
      count: serializer.fromJson<int>(json['count']),
      def: serializer.fromJson<bool>(json['def']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lowerName': serializer.toJson<String>(lowerName),
      'info': serializer.toJson<String>(info),
      'count': serializer.toJson<int>(count),
      'def': serializer.toJson<bool>(def),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Mat copyWith(
          {int id,
          String name,
          String lowerName,
          String info,
          int count,
          bool def,
          DateTime date}) =>
      Mat(
        id: id ?? this.id,
        name: name ?? this.name,
        lowerName: lowerName ?? this.lowerName,
        info: info ?? this.info,
        count: count ?? this.count,
        def: def ?? this.def,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Mat(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lowerName: $lowerName, ')
          ..write('info: $info, ')
          ..write('count: $count, ')
          ..write('def: $def, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              lowerName.hashCode,
              $mrjc(
                  info.hashCode,
                  $mrjc(
                      count.hashCode, $mrjc(def.hashCode, date.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Mat &&
          other.id == this.id &&
          other.name == this.name &&
          other.lowerName == this.lowerName &&
          other.info == this.info &&
          other.count == this.count &&
          other.def == this.def &&
          other.date == this.date);
}

class MatsCompanion extends UpdateCompanion<Mat> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lowerName;
  final Value<String> info;
  final Value<int> count;
  final Value<bool> def;
  final Value<DateTime> date;
  const MatsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lowerName = const Value.absent(),
    this.info = const Value.absent(),
    this.count = const Value.absent(),
    this.def = const Value.absent(),
    this.date = const Value.absent(),
  });
  MatsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String lowerName,
    @required String info,
    this.count = const Value.absent(),
    this.def = const Value.absent(),
    this.date = const Value.absent(),
  })  : name = Value(name),
        lowerName = Value(lowerName),
        info = Value(info);
  static Insertable<Mat> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> lowerName,
    Expression<String> info,
    Expression<int> count,
    Expression<bool> def,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lowerName != null) 'lower_name': lowerName,
      if (info != null) 'info': info,
      if (count != null) 'count': count,
      if (def != null) 'def': def,
      if (date != null) 'date': date,
    });
  }

  MatsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> lowerName,
      Value<String> info,
      Value<int> count,
      Value<bool> def,
      Value<DateTime> date}) {
    return MatsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lowerName: lowerName ?? this.lowerName,
      info: info ?? this.info,
      count: count ?? this.count,
      def: def ?? this.def,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lowerName.present) {
      map['lower_name'] = Variable<String>(lowerName.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (def.present) {
      map['def'] = Variable<bool>(def.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lowerName: $lowerName, ')
          ..write('info: $info, ')
          ..write('count: $count, ')
          ..write('def: $def, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $MatsTable extends Mats with TableInfo<$MatsTable, Mat> {
  final GeneratedDatabase _db;
  final String _alias;
  $MatsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lowerNameMeta = const VerificationMeta('lowerName');
  GeneratedTextColumn _lowerName;
  @override
  GeneratedTextColumn get lowerName => _lowerName ??= _constructLowerName();
  GeneratedTextColumn _constructLowerName() {
    return GeneratedTextColumn(
      'lower_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _infoMeta = const VerificationMeta('info');
  GeneratedTextColumn _info;
  @override
  GeneratedTextColumn get info => _info ??= _constructInfo();
  GeneratedTextColumn _constructInfo() {
    return GeneratedTextColumn(
      'info',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn('count', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _defMeta = const VerificationMeta('def');
  GeneratedBoolColumn _def;
  @override
  GeneratedBoolColumn get def => _def ??= _constructDef();
  GeneratedBoolColumn _constructDef() {
    return GeneratedBoolColumn('def', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lowerName, info, count, def, date];
  @override
  $MatsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'mats';
  @override
  final String actualTableName = 'mats';
  @override
  VerificationContext validateIntegrity(Insertable<Mat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lower_name')) {
      context.handle(_lowerNameMeta,
          lowerName.isAcceptableOrUnknown(data['lower_name'], _lowerNameMeta));
    } else if (isInserting) {
      context.missing(_lowerNameMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info'], _infoMeta));
    } else if (isInserting) {
      context.missing(_infoMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count'], _countMeta));
    }
    if (data.containsKey('def')) {
      context.handle(
          _defMeta, def.isAcceptableOrUnknown(data['def'], _defMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mat map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Mat.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MatsTable createAlias(String alias) {
    return $MatsTable(_db, alias);
  }
}

class MatOxide extends DataClass implements Insertable<MatOxide> {
  final int id;
  final int oxideId;
  final int matId;
  final double count;
  MatOxide(
      {@required this.id,
      @required this.oxideId,
      @required this.matId,
      @required this.count});
  factory MatOxide.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return MatOxide(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      oxideId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}oxide_id']),
      matId: intType.mapFromDatabaseResponse(data['${effectivePrefix}mat_id']),
      count:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || oxideId != null) {
      map['oxide_id'] = Variable<int>(oxideId);
    }
    if (!nullToAbsent || matId != null) {
      map['mat_id'] = Variable<int>(matId);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<double>(count);
    }
    return map;
  }

  MatOxidesCompanion toCompanion(bool nullToAbsent) {
    return MatOxidesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      oxideId: oxideId == null && nullToAbsent
          ? const Value.absent()
          : Value(oxideId),
      matId:
          matId == null && nullToAbsent ? const Value.absent() : Value(matId),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
    );
  }

  factory MatOxide.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MatOxide(
      id: serializer.fromJson<int>(json['id']),
      oxideId: serializer.fromJson<int>(json['oxideId']),
      matId: serializer.fromJson<int>(json['matId']),
      count: serializer.fromJson<double>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'oxideId': serializer.toJson<int>(oxideId),
      'matId': serializer.toJson<int>(matId),
      'count': serializer.toJson<double>(count),
    };
  }

  MatOxide copyWith({int id, int oxideId, int matId, double count}) => MatOxide(
        id: id ?? this.id,
        oxideId: oxideId ?? this.oxideId,
        matId: matId ?? this.matId,
        count: count ?? this.count,
      );
  @override
  String toString() {
    return (StringBuffer('MatOxide(')
          ..write('id: $id, ')
          ..write('oxideId: $oxideId, ')
          ..write('matId: $matId, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(oxideId.hashCode, $mrjc(matId.hashCode, count.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MatOxide &&
          other.id == this.id &&
          other.oxideId == this.oxideId &&
          other.matId == this.matId &&
          other.count == this.count);
}

class MatOxidesCompanion extends UpdateCompanion<MatOxide> {
  final Value<int> id;
  final Value<int> oxideId;
  final Value<int> matId;
  final Value<double> count;
  const MatOxidesCompanion({
    this.id = const Value.absent(),
    this.oxideId = const Value.absent(),
    this.matId = const Value.absent(),
    this.count = const Value.absent(),
  });
  MatOxidesCompanion.insert({
    this.id = const Value.absent(),
    @required int oxideId,
    @required int matId,
    @required double count,
  })  : oxideId = Value(oxideId),
        matId = Value(matId),
        count = Value(count);
  static Insertable<MatOxide> custom({
    Expression<int> id,
    Expression<int> oxideId,
    Expression<int> matId,
    Expression<double> count,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (oxideId != null) 'oxide_id': oxideId,
      if (matId != null) 'mat_id': matId,
      if (count != null) 'count': count,
    });
  }

  MatOxidesCompanion copyWith(
      {Value<int> id,
      Value<int> oxideId,
      Value<int> matId,
      Value<double> count}) {
    return MatOxidesCompanion(
      id: id ?? this.id,
      oxideId: oxideId ?? this.oxideId,
      matId: matId ?? this.matId,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (oxideId.present) {
      map['oxide_id'] = Variable<int>(oxideId.value);
    }
    if (matId.present) {
      map['mat_id'] = Variable<int>(matId.value);
    }
    if (count.present) {
      map['count'] = Variable<double>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatOxidesCompanion(')
          ..write('id: $id, ')
          ..write('oxideId: $oxideId, ')
          ..write('matId: $matId, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $MatOxidesTable extends MatOxides
    with TableInfo<$MatOxidesTable, MatOxide> {
  final GeneratedDatabase _db;
  final String _alias;
  $MatOxidesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _oxideIdMeta = const VerificationMeta('oxideId');
  GeneratedIntColumn _oxideId;
  @override
  GeneratedIntColumn get oxideId => _oxideId ??= _constructOxideId();
  GeneratedIntColumn _constructOxideId() {
    return GeneratedIntColumn('oxide_id', $tableName, false,
        $customConstraints: 'REFERENCES oxides(id)');
  }

  final VerificationMeta _matIdMeta = const VerificationMeta('matId');
  GeneratedIntColumn _matId;
  @override
  GeneratedIntColumn get matId => _matId ??= _constructMatId();
  GeneratedIntColumn _constructMatId() {
    return GeneratedIntColumn('mat_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES mats(id)');
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedRealColumn _count;
  @override
  GeneratedRealColumn get count => _count ??= _constructCount();
  GeneratedRealColumn _constructCount() {
    return GeneratedRealColumn(
      'count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, oxideId, matId, count];
  @override
  $MatOxidesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'mat_oxides';
  @override
  final String actualTableName = 'mat_oxides';
  @override
  VerificationContext validateIntegrity(Insertable<MatOxide> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('oxide_id')) {
      context.handle(_oxideIdMeta,
          oxideId.isAcceptableOrUnknown(data['oxide_id'], _oxideIdMeta));
    } else if (isInserting) {
      context.missing(_oxideIdMeta);
    }
    if (data.containsKey('mat_id')) {
      context.handle(
          _matIdMeta, matId.isAcceptableOrUnknown(data['mat_id'], _matIdMeta));
    } else if (isInserting) {
      context.missing(_matIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count'], _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatOxide map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MatOxide.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MatOxidesTable createAlias(String alias) {
    return $MatOxidesTable(_db, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String name;
  final DateTime date;
  final int folderId;
  final String image;
  Recipe(
      {@required this.id,
      @required this.name,
      this.date,
      this.folderId,
      this.image});
  factory Recipe.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Recipe(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      folderId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}folder_id']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<int>(folderId);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      folderId: serializer.fromJson<int>(json['folderId']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'folderId': serializer.toJson<int>(folderId),
      'image': serializer.toJson<String>(image),
    };
  }

  Recipe copyWith(
          {int id, String name, DateTime date, int folderId, String image}) =>
      Recipe(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        folderId: folderId ?? this.folderId,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('folderId: $folderId, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(date.hashCode, $mrjc(folderId.hashCode, image.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.folderId == this.folderId &&
          other.image == this.image);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<int> folderId;
  final Value<String> image;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.folderId = const Value.absent(),
    this.image = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.date = const Value.absent(),
    this.folderId = const Value.absent(),
    this.image = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Recipe> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<DateTime> date,
    Expression<int> folderId,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (folderId != null) 'folder_id': folderId,
      if (image != null) 'image': image,
    });
  }

  RecipesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> date,
      Value<int> folderId,
      Value<String> image}) {
    return RecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      folderId: folderId ?? this.folderId,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<int>(folderId.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('folderId: $folderId, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecipesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _folderIdMeta = const VerificationMeta('folderId');
  GeneratedIntColumn _folderId;
  @override
  GeneratedIntColumn get folderId => _folderId ??= _constructFolderId();
  GeneratedIntColumn _constructFolderId() {
    return GeneratedIntColumn('folder_id', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES folders(id)');
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, date, folderId, image];
  @override
  $RecipesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recipes';
  @override
  final String actualTableName = 'recipes';
  @override
  VerificationContext validateIntegrity(Insertable<Recipe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id'], _folderIdMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Recipe.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(_db, alias);
  }
}

class RecipeMat extends DataClass implements Insertable<RecipeMat> {
  final int id;
  final int matId;
  final int recipeId;
  final double count;
  final bool tag;
  RecipeMat(
      {@required this.id,
      @required this.matId,
      @required this.recipeId,
      @required this.count,
      @required this.tag});
  factory RecipeMat.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return RecipeMat(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      matId: intType.mapFromDatabaseResponse(data['${effectivePrefix}mat_id']),
      recipeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}recipe_id']),
      count:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
      tag: boolType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || matId != null) {
      map['mat_id'] = Variable<int>(matId);
    }
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<int>(recipeId);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<double>(count);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<bool>(tag);
    }
    return map;
  }

  RecipeMatsCompanion toCompanion(bool nullToAbsent) {
    return RecipeMatsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      matId:
          matId == null && nullToAbsent ? const Value.absent() : Value(matId),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
    );
  }

  factory RecipeMat.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RecipeMat(
      id: serializer.fromJson<int>(json['id']),
      matId: serializer.fromJson<int>(json['matId']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      count: serializer.fromJson<double>(json['count']),
      tag: serializer.fromJson<bool>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matId': serializer.toJson<int>(matId),
      'recipeId': serializer.toJson<int>(recipeId),
      'count': serializer.toJson<double>(count),
      'tag': serializer.toJson<bool>(tag),
    };
  }

  RecipeMat copyWith(
          {int id, int matId, int recipeId, double count, bool tag}) =>
      RecipeMat(
        id: id ?? this.id,
        matId: matId ?? this.matId,
        recipeId: recipeId ?? this.recipeId,
        count: count ?? this.count,
        tag: tag ?? this.tag,
      );
  @override
  String toString() {
    return (StringBuffer('RecipeMat(')
          ..write('id: $id, ')
          ..write('matId: $matId, ')
          ..write('recipeId: $recipeId, ')
          ..write('count: $count, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(matId.hashCode,
          $mrjc(recipeId.hashCode, $mrjc(count.hashCode, tag.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RecipeMat &&
          other.id == this.id &&
          other.matId == this.matId &&
          other.recipeId == this.recipeId &&
          other.count == this.count &&
          other.tag == this.tag);
}

class RecipeMatsCompanion extends UpdateCompanion<RecipeMat> {
  final Value<int> id;
  final Value<int> matId;
  final Value<int> recipeId;
  final Value<double> count;
  final Value<bool> tag;
  const RecipeMatsCompanion({
    this.id = const Value.absent(),
    this.matId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.count = const Value.absent(),
    this.tag = const Value.absent(),
  });
  RecipeMatsCompanion.insert({
    this.id = const Value.absent(),
    @required int matId,
    @required int recipeId,
    @required double count,
    this.tag = const Value.absent(),
  })  : matId = Value(matId),
        recipeId = Value(recipeId),
        count = Value(count);
  static Insertable<RecipeMat> custom({
    Expression<int> id,
    Expression<int> matId,
    Expression<int> recipeId,
    Expression<double> count,
    Expression<bool> tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matId != null) 'mat_id': matId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (count != null) 'count': count,
      if (tag != null) 'tag': tag,
    });
  }

  RecipeMatsCompanion copyWith(
      {Value<int> id,
      Value<int> matId,
      Value<int> recipeId,
      Value<double> count,
      Value<bool> tag}) {
    return RecipeMatsCompanion(
      id: id ?? this.id,
      matId: matId ?? this.matId,
      recipeId: recipeId ?? this.recipeId,
      count: count ?? this.count,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matId.present) {
      map['mat_id'] = Variable<int>(matId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (count.present) {
      map['count'] = Variable<double>(count.value);
    }
    if (tag.present) {
      map['tag'] = Variable<bool>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeMatsCompanion(')
          ..write('id: $id, ')
          ..write('matId: $matId, ')
          ..write('recipeId: $recipeId, ')
          ..write('count: $count, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

class $RecipeMatsTable extends RecipeMats
    with TableInfo<$RecipeMatsTable, RecipeMat> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecipeMatsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _matIdMeta = const VerificationMeta('matId');
  GeneratedIntColumn _matId;
  @override
  GeneratedIntColumn get matId => _matId ??= _constructMatId();
  GeneratedIntColumn _constructMatId() {
    return GeneratedIntColumn('mat_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES mats(id)');
  }

  final VerificationMeta _recipeIdMeta = const VerificationMeta('recipeId');
  GeneratedIntColumn _recipeId;
  @override
  GeneratedIntColumn get recipeId => _recipeId ??= _constructRecipeId();
  GeneratedIntColumn _constructRecipeId() {
    return GeneratedIntColumn('recipe_id', $tableName, false,
        $customConstraints: 'REFERENCES recipes(id)');
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedRealColumn _count;
  @override
  GeneratedRealColumn get count => _count ??= _constructCount();
  GeneratedRealColumn _constructCount() {
    return GeneratedRealColumn(
      'count',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedBoolColumn _tag;
  @override
  GeneratedBoolColumn get tag => _tag ??= _constructTag();
  GeneratedBoolColumn _constructTag() {
    return GeneratedBoolColumn('tag', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, matId, recipeId, count, tag];
  @override
  $RecipeMatsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recipe_mats';
  @override
  final String actualTableName = 'recipe_mats';
  @override
  VerificationContext validateIntegrity(Insertable<RecipeMat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('mat_id')) {
      context.handle(
          _matIdMeta, matId.isAcceptableOrUnknown(data['mat_id'], _matIdMeta));
    } else if (isInserting) {
      context.missing(_matIdMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(_recipeIdMeta,
          recipeId.isAcceptableOrUnknown(data['recipe_id'], _recipeIdMeta));
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count'], _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag'], _tagMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeMat map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RecipeMat.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RecipeMatsTable createAlias(String alias) {
    return $RecipeMatsTable(_db, alias);
  }
}

class Folder extends DataClass implements Insertable<Folder> {
  final int id;
  final String name;
  final bool del;
  Folder({@required this.id, @required this.name, @required this.del});
  factory Folder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Folder(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      del: boolType.mapFromDatabaseResponse(data['${effectivePrefix}del']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || del != null) {
      map['del'] = Variable<bool>(del);
    }
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      del: del == null && nullToAbsent ? const Value.absent() : Value(del),
    );
  }

  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Folder(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      del: serializer.fromJson<bool>(json['del']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'del': serializer.toJson<bool>(del),
    };
  }

  Folder copyWith({int id, String name, bool del}) => Folder(
        id: id ?? this.id,
        name: name ?? this.name,
        del: del ?? this.del,
      );
  @override
  String toString() {
    return (StringBuffer('Folder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('del: $del')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, del.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Folder &&
          other.id == this.id &&
          other.name == this.name &&
          other.del == this.del);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> del;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.del = const Value.absent(),
  });
  FoldersCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required bool del,
  })  : name = Value(name),
        del = Value(del);
  static Insertable<Folder> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<bool> del,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (del != null) 'del': del,
    });
  }

  FoldersCompanion copyWith(
      {Value<int> id, Value<String> name, Value<bool> del}) {
    return FoldersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      del: del ?? this.del,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (del.present) {
      map['del'] = Variable<bool>(del.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('del: $del')
          ..write(')'))
        .toString();
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoldersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _delMeta = const VerificationMeta('del');
  GeneratedBoolColumn _del;
  @override
  GeneratedBoolColumn get del => _del ??= _constructDel();
  GeneratedBoolColumn _constructDel() {
    return GeneratedBoolColumn(
      'del',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, del];
  @override
  $FoldersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folders';
  @override
  final String actualTableName = 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<Folder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('del')) {
      context.handle(
          _delMeta, del.isAcceptableOrUnknown(data['del'], _delMeta));
    } else if (isInserting) {
      context.missing(_delMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Folder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Folder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $OxidesTable _oxides;
  $OxidesTable get oxides => _oxides ??= $OxidesTable(this);
  $MatsTable _mats;
  $MatsTable get mats => _mats ??= $MatsTable(this);
  $MatOxidesTable _matOxides;
  $MatOxidesTable get matOxides => _matOxides ??= $MatOxidesTable(this);
  $RecipesTable _recipes;
  $RecipesTable get recipes => _recipes ??= $RecipesTable(this);
  $RecipeMatsTable _recipeMats;
  $RecipeMatsTable get recipeMats => _recipeMats ??= $RecipeMatsTable(this);
  $FoldersTable _folders;
  $FoldersTable get folders => _folders ??= $FoldersTable(this);
  OxideDao _oxideDao;
  OxideDao get oxideDao => _oxideDao ??= OxideDao(this as AppDatabase);
  MatDao _matDao;
  MatDao get matDao => _matDao ??= MatDao(this as AppDatabase);
  MatOxideDao _matOxideDao;
  MatOxideDao get matOxideDao =>
      _matOxideDao ??= MatOxideDao(this as AppDatabase);
  FolderDao _folderDao;
  FolderDao get folderDao => _folderDao ??= FolderDao(this as AppDatabase);
  RecipeDao _recipeDao;
  RecipeDao get recipeDao => _recipeDao ??= RecipeDao(this as AppDatabase);
  RecipeMatDao _recipeMatDao;
  RecipeMatDao get recipeMatDao =>
      _recipeMatDao ??= RecipeMatDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [oxides, mats, matOxides, recipes, recipeMats, folders];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$OxideDaoMixin on DatabaseAccessor<AppDatabase> {
  $OxidesTable get oxides => attachedDatabase.oxides;
}
mixin _$MatDaoMixin on DatabaseAccessor<AppDatabase> {
  $MatsTable get mats => attachedDatabase.mats;
}
mixin _$MatOxideDaoMixin on DatabaseAccessor<AppDatabase> {
  $MatOxidesTable get matOxides => attachedDatabase.matOxides;
  $MatsTable get mats => attachedDatabase.mats;
  $OxidesTable get oxides => attachedDatabase.oxides;
}
mixin _$RecipeDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipesTable get recipes => attachedDatabase.recipes;
}
mixin _$RecipeMatDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipeMatsTable get recipeMats => attachedDatabase.recipeMats;
}
mixin _$FolderDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoldersTable get folders => attachedDatabase.folders;
}
