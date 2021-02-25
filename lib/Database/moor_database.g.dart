// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Order extends DataClass implements Insertable<Order> {
  final String price;
  final int id;
  final String productName;
  Order({@required this.price, @required this.id, @required this.productName});
  factory Order.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Order(
      price:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name']),
    );
  }
  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Order(
      price: serializer.fromJson<String>(json['price']),
      id: serializer.fromJson<int>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'price': serializer.toJson<String>(price),
      'id': serializer.toJson<int>(id),
      'productName': serializer.toJson<String>(productName),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Order>>(bool nullToAbsent) {
    return OrdersCompanion(
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
    ) as T;
  }

  Order copyWith({String price, int id, String productName}) => Order(
        price: price ?? this.price,
        id: id ?? this.id,
        productName: productName ?? this.productName,
      );
  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('price: $price, ')
          ..write('id: $id, ')
          ..write('productName: $productName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(price.hashCode, $mrjc(id.hashCode, productName.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Order &&
          other.price == price &&
          other.id == id &&
          other.productName == productName);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> price;
  final Value<int> id;
  final Value<String> productName;
  const OrdersCompanion({
    this.price = const Value.absent(),
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
  });
  OrdersCompanion copyWith(
      {Value<String> price, Value<int> id, Value<String> productName}) {
    return OrdersCompanion(
      price: price ?? this.price,
      id: id ?? this.id,
      productName: productName ?? this.productName,
    );
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrdersTable(this._db, [this._alias]);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedTextColumn _price;
  @override
  GeneratedTextColumn get price => _price ??= _constructPrice();
  GeneratedTextColumn _constructPrice() {
    return GeneratedTextColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  GeneratedTextColumn _productName;
  @override
  GeneratedTextColumn get productName =>
      _productName ??= _constructProductName();
  GeneratedTextColumn _constructProductName() {
    return GeneratedTextColumn(
      'product_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [price, id, productName];
  @override
  $OrdersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'orders';
  @override
  final String actualTableName = 'orders';
  @override
  VerificationContext validateIntegrity(OrdersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.price.present) {
      context.handle(
          _priceMeta, price.isAcceptableValue(d.price.value, _priceMeta));
    } else if (price.isRequired && isInserting) {
      context.missing(_priceMeta);
    }
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.productName.present) {
      context.handle(_productNameMeta,
          productName.isAcceptableValue(d.productName.value, _productNameMeta));
    } else if (productName.isRequired && isInserting) {
      context.missing(_productNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Order.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(OrdersCompanion d) {
    final map = <String, Variable>{};
    if (d.price.present) {
      map['price'] = Variable<String, StringType>(d.price.value);
    }
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.productName.present) {
      map['product_name'] = Variable<String, StringType>(d.productName.value);
    }
    return map;
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(_db, alias);
  }
}

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
  factory Oxide.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Oxide(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      defRole: serializer.fromJson<String>(json['defRole']),
      mass: serializer.fromJson<double>(json['mass']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'defRole': serializer.toJson<String>(defRole),
      'mass': serializer.toJson<double>(mass),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Oxide>>(bool nullToAbsent) {
    return OxidesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      defRole: defRole == null && nullToAbsent
          ? const Value.absent()
          : Value(defRole),
      mass: mass == null && nullToAbsent ? const Value.absent() : Value(mass),
    ) as T;
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
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Oxide &&
          other.id == id &&
          other.name == name &&
          other.role == role &&
          other.defRole == defRole &&
          other.mass == mass);
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
  VerificationContext validateIntegrity(OxidesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.role.present) {
      context.handle(
          _roleMeta, role.isAcceptableValue(d.role.value, _roleMeta));
    } else if (role.isRequired && isInserting) {
      context.missing(_roleMeta);
    }
    if (d.defRole.present) {
      context.handle(_defRoleMeta,
          defRole.isAcceptableValue(d.defRole.value, _defRoleMeta));
    } else if (defRole.isRequired && isInserting) {
      context.missing(_defRoleMeta);
    }
    if (d.mass.present) {
      context.handle(
          _massMeta, mass.isAcceptableValue(d.mass.value, _massMeta));
    } else if (mass.isRequired && isInserting) {
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
  Map<String, Variable> entityToSql(OxidesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.role.present) {
      map['role'] = Variable<String, StringType>(d.role.value);
    }
    if (d.defRole.present) {
      map['def_role'] = Variable<String, StringType>(d.defRole.value);
    }
    if (d.mass.present) {
      map['mass'] = Variable<double, RealType>(d.mass.value);
    }
    return map;
  }

  @override
  $OxidesTable createAlias(String alias) {
    return $OxidesTable(_db, alias);
  }
}

class Mat extends DataClass implements Insertable<Mat> {
  final int id;
  final String name;
  final String info;
  final bool def;
  Mat(
      {@required this.id,
      @required this.name,
      @required this.info,
      @required this.def});
  factory Mat.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Mat(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      info: stringType.mapFromDatabaseResponse(data['${effectivePrefix}info']),
      def: boolType.mapFromDatabaseResponse(data['${effectivePrefix}def']),
    );
  }
  factory Mat.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Mat(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      info: serializer.fromJson<String>(json['info']),
      def: serializer.fromJson<bool>(json['def']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'info': serializer.toJson<String>(info),
      'def': serializer.toJson<bool>(def),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Mat>>(bool nullToAbsent) {
    return MatsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
      def: def == null && nullToAbsent ? const Value.absent() : Value(def),
    ) as T;
  }

  Mat copyWith({int id, String name, String info, bool def}) => Mat(
        id: id ?? this.id,
        name: name ?? this.name,
        info: info ?? this.info,
        def: def ?? this.def,
      );
  @override
  String toString() {
    return (StringBuffer('Mat(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('info: $info, ')
          ..write('def: $def')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(name.hashCode, $mrjc(info.hashCode, def.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Mat &&
          other.id == id &&
          other.name == name &&
          other.info == info &&
          other.def == def);
}

class MatsCompanion extends UpdateCompanion<Mat> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> info;
  final Value<bool> def;
  const MatsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.info = const Value.absent(),
    this.def = const Value.absent(),
  });
  MatsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> info,
      Value<bool> def}) {
    return MatsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      info: info ?? this.info,
      def: def ?? this.def,
    );
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

  final VerificationMeta _defMeta = const VerificationMeta('def');
  GeneratedBoolColumn _def;
  @override
  GeneratedBoolColumn get def => _def ??= _constructDef();
  GeneratedBoolColumn _constructDef() {
    return GeneratedBoolColumn(
      'def',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, info, def];
  @override
  $MatsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'mats';
  @override
  final String actualTableName = 'mats';
  @override
  VerificationContext validateIntegrity(MatsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.info.present) {
      context.handle(
          _infoMeta, info.isAcceptableValue(d.info.value, _infoMeta));
    } else if (info.isRequired && isInserting) {
      context.missing(_infoMeta);
    }
    if (d.def.present) {
      context.handle(_defMeta, def.isAcceptableValue(d.def.value, _defMeta));
    } else if (def.isRequired && isInserting) {
      context.missing(_defMeta);
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
  Map<String, Variable> entityToSql(MatsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.info.present) {
      map['info'] = Variable<String, StringType>(d.info.value);
    }
    if (d.def.present) {
      map['def'] = Variable<bool, BoolType>(d.def.value);
    }
    return map;
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
  factory MatOxide.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MatOxide(
      id: serializer.fromJson<int>(json['id']),
      oxideId: serializer.fromJson<int>(json['oxideId']),
      matId: serializer.fromJson<int>(json['matId']),
      count: serializer.fromJson<double>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'oxideId': serializer.toJson<int>(oxideId),
      'matId': serializer.toJson<int>(matId),
      'count': serializer.toJson<double>(count),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<MatOxide>>(bool nullToAbsent) {
    return MatOxidesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      oxideId: oxideId == null && nullToAbsent
          ? const Value.absent()
          : Value(oxideId),
      matId:
          matId == null && nullToAbsent ? const Value.absent() : Value(matId),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
    ) as T;
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
  bool operator ==(other) =>
      identical(this, other) ||
      (other is MatOxide &&
          other.id == id &&
          other.oxideId == oxideId &&
          other.matId == matId &&
          other.count == count);
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
        $customConstraints: 'REFERENCES materials(id)');
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
  VerificationContext validateIntegrity(MatOxidesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.oxideId.present) {
      context.handle(_oxideIdMeta,
          oxideId.isAcceptableValue(d.oxideId.value, _oxideIdMeta));
    } else if (oxideId.isRequired && isInserting) {
      context.missing(_oxideIdMeta);
    }
    if (d.matId.present) {
      context.handle(
          _matIdMeta, matId.isAcceptableValue(d.matId.value, _matIdMeta));
    } else if (matId.isRequired && isInserting) {
      context.missing(_matIdMeta);
    }
    if (d.count.present) {
      context.handle(
          _countMeta, count.isAcceptableValue(d.count.value, _countMeta));
    } else if (count.isRequired && isInserting) {
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
  Map<String, Variable> entityToSql(MatOxidesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.oxideId.present) {
      map['oxide_id'] = Variable<int, IntType>(d.oxideId.value);
    }
    if (d.matId.present) {
      map['mat_id'] = Variable<int, IntType>(d.matId.value);
    }
    if (d.count.present) {
      map['count'] = Variable<double, RealType>(d.count.value);
    }
    return map;
  }

  @override
  $MatOxidesTable createAlias(String alias) {
    return $MatOxidesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $OrdersTable _orders;
  $OrdersTable get orders => _orders ??= $OrdersTable(this);
  $OxidesTable _oxides;
  $OxidesTable get oxides => _oxides ??= $OxidesTable(this);
  $MatsTable _mats;
  $MatsTable get mats => _mats ??= $MatsTable(this);
  $MatOxidesTable _matOxides;
  $MatOxidesTable get matOxides => _matOxides ??= $MatOxidesTable(this);
  OxideDao _oxideDao;
  OxideDao get oxideDao => _oxideDao ??= OxideDao(this as AppDatabase);
  MatDao _matDao;
  MatDao get matDao => _matDao ??= MatDao(this as AppDatabase);
  MatOxideDao _matOxideDao;
  MatOxideDao get matOxideDao =>
      _matOxideDao ??= MatOxideDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [orders, oxides, mats, matOxides];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$OxideDaoMixin on DatabaseAccessor<AppDatabase> {
  $OxidesTable get oxides => db.oxides;
}

mixin _$MatDaoMixin on DatabaseAccessor<AppDatabase> {
  $MatsTable get mats => db.mats;
}

mixin _$MatOxideDaoMixin on DatabaseAccessor<AppDatabase> {
  $MatOxidesTable get matOxides => db.matOxides;
  $MatsTable get mats => db.mats;
  $OxidesTable get oxides => db.oxides;
}
