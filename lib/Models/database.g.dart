// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updated_atMeta = const VerificationMeta(
    'updated_at',
  );
  @override
  late final GeneratedColumn<DateTime> updated_at = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deleted_atMeta = const VerificationMeta(
    'deleted_at',
  );
  @override
  late final GeneratedColumn<DateTime> deleted_at = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    created,
    updated_at,
    deleted_at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updated_atMeta,
        updated_at.isAcceptableOrUnknown(data['updated_at']!, _updated_atMeta),
      );
    } else if (isInserting) {
      context.missing(_updated_atMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deleted_atMeta,
        deleted_at.isAcceptableOrUnknown(data['deleted_at']!, _deleted_atMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      updated_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int type;
  final DateTime created;
  final DateTime updated_at;
  final DateTime? deleted_at;
  const Category({
    required this.id,
    required this.name,
    required this.type,
    required this.created,
    required this.updated_at,
    this.deleted_at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<int>(type);
    map['created'] = Variable<DateTime>(created);
    map['updated_at'] = Variable<DateTime>(updated_at);
    if (!nullToAbsent || deleted_at != null) {
      map['deleted_at'] = Variable<DateTime>(deleted_at);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      created: Value(created),
      updated_at: Value(updated_at),
      deleted_at: deleted_at == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted_at),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<int>(json['type']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated_at: serializer.fromJson<DateTime>(json['updated_at']),
      deleted_at: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<int>(type),
      'created': serializer.toJson<DateTime>(created),
      'updated_at': serializer.toJson<DateTime>(updated_at),
      'deleted_at': serializer.toJson<DateTime?>(deleted_at),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    int? type,
    DateTime? created,
    DateTime? updated_at,
    Value<DateTime?> deleted_at = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    created: created ?? this.created,
    updated_at: updated_at ?? this.updated_at,
    deleted_at: deleted_at.present ? deleted_at.value : this.deleted_at,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      created: data.created.present ? data.created.value : this.created,
      updated_at: data.updated_at.present
          ? data.updated_at.value
          : this.updated_at,
      deleted_at: data.deleted_at.present
          ? data.deleted_at.value
          : this.deleted_at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, created, updated_at, deleted_at);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.created == this.created &&
          other.updated_at == this.updated_at &&
          other.deleted_at == this.deleted_at);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> type;
  final Value<DateTime> created;
  final Value<DateTime> updated_at;
  final Value<DateTime?> deleted_at;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.created = const Value.absent(),
    this.updated_at = const Value.absent(),
    this.deleted_at = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int type,
    required DateTime created,
    required DateTime updated_at,
    this.deleted_at = const Value.absent(),
  }) : name = Value(name),
       type = Value(type),
       created = Value(created),
       updated_at = Value(updated_at);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? type,
    Expression<DateTime>? created,
    Expression<DateTime>? updated_at,
    Expression<DateTime>? deleted_at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (created != null) 'created': created,
      if (updated_at != null) 'updated_at': updated_at,
      if (deleted_at != null) 'deleted_at': deleted_at,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? type,
    Value<DateTime>? created,
    Value<DateTime>? updated_at,
    Value<DateTime?>? deleted_at,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      created: created ?? this.created,
      updated_at: updated_at ?? this.updated_at,
      deleted_at: deleted_at ?? this.deleted_at,
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
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated_at.present) {
      map['updated_at'] = Variable<DateTime>(updated_at.value);
    }
    if (deleted_at.present) {
      map['deleted_at'] = Variable<DateTime>(deleted_at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _category_idMeta = const VerificationMeta(
    'category_id',
  );
  @override
  late final GeneratedColumn<int> category_id = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wallet_idMeta = const VerificationMeta(
    'wallet_id',
  );
  @override
  late final GeneratedColumn<int> wallet_id = GeneratedColumn<int>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transaction_dateMeta = const VerificationMeta(
    'transaction_date',
  );
  @override
  late final GeneratedColumn<DateTime> transaction_date =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updated_atMeta = const VerificationMeta(
    'updated_at',
  );
  @override
  late final GeneratedColumn<DateTime> updated_at = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deleted_atMeta = const VerificationMeta(
    'deleted_at',
  );
  @override
  late final GeneratedColumn<DateTime> deleted_at = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category_id,
    wallet_id,
    transaction_date,
    amount,
    created,
    updated_at,
    deleted_at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _category_idMeta,
        category_id.isAcceptableOrUnknown(
          data['category_id']!,
          _category_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_category_idMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _wallet_idMeta,
        wallet_id.isAcceptableOrUnknown(data['wallet_id']!, _wallet_idMeta),
      );
    } else if (isInserting) {
      context.missing(_wallet_idMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transaction_dateMeta,
        transaction_date.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transaction_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transaction_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updated_atMeta,
        updated_at.isAcceptableOrUnknown(data['updated_at']!, _updated_atMeta),
      );
    } else if (isInserting) {
      context.missing(_updated_atMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deleted_atMeta,
        deleted_at.isAcceptableOrUnknown(data['deleted_at']!, _deleted_atMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category_id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      wallet_id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wallet_id'],
      )!,
      transaction_date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      updated_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String name;
  final int category_id;
  final int wallet_id;
  final DateTime transaction_date;
  final int amount;
  final DateTime created;
  final DateTime updated_at;
  final DateTime? deleted_at;
  const Transaction({
    required this.id,
    required this.name,
    required this.category_id,
    required this.wallet_id,
    required this.transaction_date,
    required this.amount,
    required this.created,
    required this.updated_at,
    this.deleted_at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<int>(category_id);
    map['wallet_id'] = Variable<int>(wallet_id);
    map['transaction_date'] = Variable<DateTime>(transaction_date);
    map['amount'] = Variable<int>(amount);
    map['created'] = Variable<DateTime>(created);
    map['updated_at'] = Variable<DateTime>(updated_at);
    if (!nullToAbsent || deleted_at != null) {
      map['deleted_at'] = Variable<DateTime>(deleted_at);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      name: Value(name),
      category_id: Value(category_id),
      wallet_id: Value(wallet_id),
      transaction_date: Value(transaction_date),
      amount: Value(amount),
      created: Value(created),
      updated_at: Value(updated_at),
      deleted_at: deleted_at == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted_at),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category_id: serializer.fromJson<int>(json['category_id']),
      wallet_id: serializer.fromJson<int>(json['wallet_id']),
      transaction_date: serializer.fromJson<DateTime>(json['transaction_date']),
      amount: serializer.fromJson<int>(json['amount']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated_at: serializer.fromJson<DateTime>(json['updated_at']),
      deleted_at: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category_id': serializer.toJson<int>(category_id),
      'wallet_id': serializer.toJson<int>(wallet_id),
      'transaction_date': serializer.toJson<DateTime>(transaction_date),
      'amount': serializer.toJson<int>(amount),
      'created': serializer.toJson<DateTime>(created),
      'updated_at': serializer.toJson<DateTime>(updated_at),
      'deleted_at': serializer.toJson<DateTime?>(deleted_at),
    };
  }

  Transaction copyWith({
    int? id,
    String? name,
    int? category_id,
    int? wallet_id,
    DateTime? transaction_date,
    int? amount,
    DateTime? created,
    DateTime? updated_at,
    Value<DateTime?> deleted_at = const Value.absent(),
  }) => Transaction(
    id: id ?? this.id,
    name: name ?? this.name,
    category_id: category_id ?? this.category_id,
    wallet_id: wallet_id ?? this.wallet_id,
    transaction_date: transaction_date ?? this.transaction_date,
    amount: amount ?? this.amount,
    created: created ?? this.created,
    updated_at: updated_at ?? this.updated_at,
    deleted_at: deleted_at.present ? deleted_at.value : this.deleted_at,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category_id: data.category_id.present
          ? data.category_id.value
          : this.category_id,
      wallet_id: data.wallet_id.present ? data.wallet_id.value : this.wallet_id,
      transaction_date: data.transaction_date.present
          ? data.transaction_date.value
          : this.transaction_date,
      amount: data.amount.present ? data.amount.value : this.amount,
      created: data.created.present ? data.created.value : this.created,
      updated_at: data.updated_at.present
          ? data.updated_at.value
          : this.updated_at,
      deleted_at: data.deleted_at.present
          ? data.deleted_at.value
          : this.deleted_at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category_id: $category_id, ')
          ..write('wallet_id: $wallet_id, ')
          ..write('transaction_date: $transaction_date, ')
          ..write('amount: $amount, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category_id,
    wallet_id,
    transaction_date,
    amount,
    created,
    updated_at,
    deleted_at,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.name == this.name &&
          other.category_id == this.category_id &&
          other.wallet_id == this.wallet_id &&
          other.transaction_date == this.transaction_date &&
          other.amount == this.amount &&
          other.created == this.created &&
          other.updated_at == this.updated_at &&
          other.deleted_at == this.deleted_at);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> category_id;
  final Value<int> wallet_id;
  final Value<DateTime> transaction_date;
  final Value<int> amount;
  final Value<DateTime> created;
  final Value<DateTime> updated_at;
  final Value<DateTime?> deleted_at;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category_id = const Value.absent(),
    this.wallet_id = const Value.absent(),
    this.transaction_date = const Value.absent(),
    this.amount = const Value.absent(),
    this.created = const Value.absent(),
    this.updated_at = const Value.absent(),
    this.deleted_at = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int category_id,
    required int wallet_id,
    required DateTime transaction_date,
    required int amount,
    required DateTime created,
    required DateTime updated_at,
    this.deleted_at = const Value.absent(),
  }) : name = Value(name),
       category_id = Value(category_id),
       wallet_id = Value(wallet_id),
       transaction_date = Value(transaction_date),
       amount = Value(amount),
       created = Value(created),
       updated_at = Value(updated_at);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? category_id,
    Expression<int>? wallet_id,
    Expression<DateTime>? transaction_date,
    Expression<int>? amount,
    Expression<DateTime>? created,
    Expression<DateTime>? updated_at,
    Expression<DateTime>? deleted_at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category_id != null) 'category_id': category_id,
      if (wallet_id != null) 'wallet_id': wallet_id,
      if (transaction_date != null) 'transaction_date': transaction_date,
      if (amount != null) 'amount': amount,
      if (created != null) 'created': created,
      if (updated_at != null) 'updated_at': updated_at,
      if (deleted_at != null) 'deleted_at': deleted_at,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? category_id,
    Value<int>? wallet_id,
    Value<DateTime>? transaction_date,
    Value<int>? amount,
    Value<DateTime>? created,
    Value<DateTime>? updated_at,
    Value<DateTime?>? deleted_at,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category_id: category_id ?? this.category_id,
      wallet_id: wallet_id ?? this.wallet_id,
      transaction_date: transaction_date ?? this.transaction_date,
      amount: amount ?? this.amount,
      created: created ?? this.created,
      updated_at: updated_at ?? this.updated_at,
      deleted_at: deleted_at ?? this.deleted_at,
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
    if (category_id.present) {
      map['category_id'] = Variable<int>(category_id.value);
    }
    if (wallet_id.present) {
      map['wallet_id'] = Variable<int>(wallet_id.value);
    }
    if (transaction_date.present) {
      map['transaction_date'] = Variable<DateTime>(transaction_date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated_at.present) {
      map['updated_at'] = Variable<DateTime>(updated_at.value);
    }
    if (deleted_at.present) {
      map['deleted_at'] = Variable<DateTime>(deleted_at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category_id: $category_id, ')
          ..write('wallet_id: $wallet_id, ')
          ..write('transaction_date: $transaction_date, ')
          ..write('amount: $amount, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }
}

class $WalletTable extends Wallet with TableInfo<$WalletTable, WalletData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updated_atMeta = const VerificationMeta(
    'updated_at',
  );
  @override
  late final GeneratedColumn<DateTime> updated_at = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deleted_atMeta = const VerificationMeta(
    'deleted_at',
  );
  @override
  late final GeneratedColumn<DateTime> deleted_at = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    balance,
    created,
    updated_at,
    deleted_at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updated_atMeta,
        updated_at.isAcceptableOrUnknown(data['updated_at']!, _updated_atMeta),
      );
    } else if (isInserting) {
      context.missing(_updated_atMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deleted_atMeta,
        deleted_at.isAcceptableOrUnknown(data['deleted_at']!, _deleted_atMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalletData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      updated_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $WalletTable createAlias(String alias) {
    return $WalletTable(attachedDatabase, alias);
  }
}

class WalletData extends DataClass implements Insertable<WalletData> {
  final int id;
  final String name;
  final double balance;
  final DateTime created;
  final DateTime updated_at;
  final DateTime? deleted_at;
  const WalletData({
    required this.id,
    required this.name,
    required this.balance,
    required this.created,
    required this.updated_at,
    this.deleted_at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['balance'] = Variable<double>(balance);
    map['created'] = Variable<DateTime>(created);
    map['updated_at'] = Variable<DateTime>(updated_at);
    if (!nullToAbsent || deleted_at != null) {
      map['deleted_at'] = Variable<DateTime>(deleted_at);
    }
    return map;
  }

  WalletCompanion toCompanion(bool nullToAbsent) {
    return WalletCompanion(
      id: Value(id),
      name: Value(name),
      balance: Value(balance),
      created: Value(created),
      updated_at: Value(updated_at),
      deleted_at: deleted_at == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted_at),
    );
  }

  factory WalletData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      balance: serializer.fromJson<double>(json['balance']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated_at: serializer.fromJson<DateTime>(json['updated_at']),
      deleted_at: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'balance': serializer.toJson<double>(balance),
      'created': serializer.toJson<DateTime>(created),
      'updated_at': serializer.toJson<DateTime>(updated_at),
      'deleted_at': serializer.toJson<DateTime?>(deleted_at),
    };
  }

  WalletData copyWith({
    int? id,
    String? name,
    double? balance,
    DateTime? created,
    DateTime? updated_at,
    Value<DateTime?> deleted_at = const Value.absent(),
  }) => WalletData(
    id: id ?? this.id,
    name: name ?? this.name,
    balance: balance ?? this.balance,
    created: created ?? this.created,
    updated_at: updated_at ?? this.updated_at,
    deleted_at: deleted_at.present ? deleted_at.value : this.deleted_at,
  );
  WalletData copyWithCompanion(WalletCompanion data) {
    return WalletData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      balance: data.balance.present ? data.balance.value : this.balance,
      created: data.created.present ? data.created.value : this.created,
      updated_at: data.updated_at.present
          ? data.updated_at.value
          : this.updated_at,
      deleted_at: data.deleted_at.present
          ? data.deleted_at.value
          : this.deleted_at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, balance, created, updated_at, deleted_at);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletData &&
          other.id == this.id &&
          other.name == this.name &&
          other.balance == this.balance &&
          other.created == this.created &&
          other.updated_at == this.updated_at &&
          other.deleted_at == this.deleted_at);
}

class WalletCompanion extends UpdateCompanion<WalletData> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> balance;
  final Value<DateTime> created;
  final Value<DateTime> updated_at;
  final Value<DateTime?> deleted_at;
  const WalletCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.balance = const Value.absent(),
    this.created = const Value.absent(),
    this.updated_at = const Value.absent(),
    this.deleted_at = const Value.absent(),
  });
  WalletCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.balance = const Value.absent(),
    required DateTime created,
    required DateTime updated_at,
    this.deleted_at = const Value.absent(),
  }) : name = Value(name),
       created = Value(created),
       updated_at = Value(updated_at);
  static Insertable<WalletData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? balance,
    Expression<DateTime>? created,
    Expression<DateTime>? updated_at,
    Expression<DateTime>? deleted_at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (balance != null) 'balance': balance,
      if (created != null) 'created': created,
      if (updated_at != null) 'updated_at': updated_at,
      if (deleted_at != null) 'deleted_at': deleted_at,
    });
  }

  WalletCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? balance,
    Value<DateTime>? created,
    Value<DateTime>? updated_at,
    Value<DateTime?>? deleted_at,
  }) {
    return WalletCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      created: created ?? this.created,
      updated_at: updated_at ?? this.updated_at,
      deleted_at: deleted_at ?? this.deleted_at,
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
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated_at.present) {
      map['updated_at'] = Variable<DateTime>(updated_at.value);
    }
    if (deleted_at.present) {
      map['deleted_at'] = Variable<DateTime>(deleted_at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at, ')
          ..write('deleted_at: $deleted_at')
          ..write(')'))
        .toString();
  }
}

class $TransfersTable extends Transfers
    with TableInfo<$TransfersTable, Transfer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _source_wallet_idMeta = const VerificationMeta(
    'source_wallet_id',
  );
  @override
  late final GeneratedColumn<int> source_wallet_id = GeneratedColumn<int>(
    'source_wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _target_wallet_idMeta = const VerificationMeta(
    'target_wallet_id',
  );
  @override
  late final GeneratedColumn<int> target_wallet_id = GeneratedColumn<int>(
    'target_wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transfer_dateMeta = const VerificationMeta(
    'transfer_date',
  );
  @override
  late final GeneratedColumn<DateTime> transfer_date =
      GeneratedColumn<DateTime>(
        'transfer_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updated_atMeta = const VerificationMeta(
    'updated_at',
  );
  @override
  late final GeneratedColumn<DateTime> updated_at = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source_wallet_id,
    target_wallet_id,
    amount,
    transfer_date,
    notes,
    created,
    updated_at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transfer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_wallet_id')) {
      context.handle(
        _source_wallet_idMeta,
        source_wallet_id.isAcceptableOrUnknown(
          data['source_wallet_id']!,
          _source_wallet_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_source_wallet_idMeta);
    }
    if (data.containsKey('target_wallet_id')) {
      context.handle(
        _target_wallet_idMeta,
        target_wallet_id.isAcceptableOrUnknown(
          data['target_wallet_id']!,
          _target_wallet_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_target_wallet_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('transfer_date')) {
      context.handle(
        _transfer_dateMeta,
        transfer_date.isAcceptableOrUnknown(
          data['transfer_date']!,
          _transfer_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transfer_dateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updated_atMeta,
        updated_at.isAcceptableOrUnknown(data['updated_at']!, _updated_atMeta),
      );
    } else if (isInserting) {
      context.missing(_updated_atMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transfer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transfer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      source_wallet_id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_wallet_id'],
      )!,
      target_wallet_id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_wallet_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transfer_date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transfer_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      updated_at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransfersTable createAlias(String alias) {
    return $TransfersTable(attachedDatabase, alias);
  }
}

class Transfer extends DataClass implements Insertable<Transfer> {
  final int id;
  final int source_wallet_id;
  final int target_wallet_id;
  final double amount;
  final DateTime transfer_date;
  final String? notes;
  final DateTime created;
  final DateTime updated_at;
  const Transfer({
    required this.id,
    required this.source_wallet_id,
    required this.target_wallet_id,
    required this.amount,
    required this.transfer_date,
    this.notes,
    required this.created,
    required this.updated_at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_wallet_id'] = Variable<int>(source_wallet_id);
    map['target_wallet_id'] = Variable<int>(target_wallet_id);
    map['amount'] = Variable<double>(amount);
    map['transfer_date'] = Variable<DateTime>(transfer_date);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created'] = Variable<DateTime>(created);
    map['updated_at'] = Variable<DateTime>(updated_at);
    return map;
  }

  TransfersCompanion toCompanion(bool nullToAbsent) {
    return TransfersCompanion(
      id: Value(id),
      source_wallet_id: Value(source_wallet_id),
      target_wallet_id: Value(target_wallet_id),
      amount: Value(amount),
      transfer_date: Value(transfer_date),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      created: Value(created),
      updated_at: Value(updated_at),
    );
  }

  factory Transfer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transfer(
      id: serializer.fromJson<int>(json['id']),
      source_wallet_id: serializer.fromJson<int>(json['source_wallet_id']),
      target_wallet_id: serializer.fromJson<int>(json['target_wallet_id']),
      amount: serializer.fromJson<double>(json['amount']),
      transfer_date: serializer.fromJson<DateTime>(json['transfer_date']),
      notes: serializer.fromJson<String?>(json['notes']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated_at: serializer.fromJson<DateTime>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'source_wallet_id': serializer.toJson<int>(source_wallet_id),
      'target_wallet_id': serializer.toJson<int>(target_wallet_id),
      'amount': serializer.toJson<double>(amount),
      'transfer_date': serializer.toJson<DateTime>(transfer_date),
      'notes': serializer.toJson<String?>(notes),
      'created': serializer.toJson<DateTime>(created),
      'updated_at': serializer.toJson<DateTime>(updated_at),
    };
  }

  Transfer copyWith({
    int? id,
    int? source_wallet_id,
    int? target_wallet_id,
    double? amount,
    DateTime? transfer_date,
    Value<String?> notes = const Value.absent(),
    DateTime? created,
    DateTime? updated_at,
  }) => Transfer(
    id: id ?? this.id,
    source_wallet_id: source_wallet_id ?? this.source_wallet_id,
    target_wallet_id: target_wallet_id ?? this.target_wallet_id,
    amount: amount ?? this.amount,
    transfer_date: transfer_date ?? this.transfer_date,
    notes: notes.present ? notes.value : this.notes,
    created: created ?? this.created,
    updated_at: updated_at ?? this.updated_at,
  );
  Transfer copyWithCompanion(TransfersCompanion data) {
    return Transfer(
      id: data.id.present ? data.id.value : this.id,
      source_wallet_id: data.source_wallet_id.present
          ? data.source_wallet_id.value
          : this.source_wallet_id,
      target_wallet_id: data.target_wallet_id.present
          ? data.target_wallet_id.value
          : this.target_wallet_id,
      amount: data.amount.present ? data.amount.value : this.amount,
      transfer_date: data.transfer_date.present
          ? data.transfer_date.value
          : this.transfer_date,
      notes: data.notes.present ? data.notes.value : this.notes,
      created: data.created.present ? data.created.value : this.created,
      updated_at: data.updated_at.present
          ? data.updated_at.value
          : this.updated_at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transfer(')
          ..write('id: $id, ')
          ..write('source_wallet_id: $source_wallet_id, ')
          ..write('target_wallet_id: $target_wallet_id, ')
          ..write('amount: $amount, ')
          ..write('transfer_date: $transfer_date, ')
          ..write('notes: $notes, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source_wallet_id,
    target_wallet_id,
    amount,
    transfer_date,
    notes,
    created,
    updated_at,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transfer &&
          other.id == this.id &&
          other.source_wallet_id == this.source_wallet_id &&
          other.target_wallet_id == this.target_wallet_id &&
          other.amount == this.amount &&
          other.transfer_date == this.transfer_date &&
          other.notes == this.notes &&
          other.created == this.created &&
          other.updated_at == this.updated_at);
}

class TransfersCompanion extends UpdateCompanion<Transfer> {
  final Value<int> id;
  final Value<int> source_wallet_id;
  final Value<int> target_wallet_id;
  final Value<double> amount;
  final Value<DateTime> transfer_date;
  final Value<String?> notes;
  final Value<DateTime> created;
  final Value<DateTime> updated_at;
  const TransfersCompanion({
    this.id = const Value.absent(),
    this.source_wallet_id = const Value.absent(),
    this.target_wallet_id = const Value.absent(),
    this.amount = const Value.absent(),
    this.transfer_date = const Value.absent(),
    this.notes = const Value.absent(),
    this.created = const Value.absent(),
    this.updated_at = const Value.absent(),
  });
  TransfersCompanion.insert({
    this.id = const Value.absent(),
    required int source_wallet_id,
    required int target_wallet_id,
    required double amount,
    required DateTime transfer_date,
    this.notes = const Value.absent(),
    required DateTime created,
    required DateTime updated_at,
  }) : source_wallet_id = Value(source_wallet_id),
       target_wallet_id = Value(target_wallet_id),
       amount = Value(amount),
       transfer_date = Value(transfer_date),
       created = Value(created),
       updated_at = Value(updated_at);
  static Insertable<Transfer> custom({
    Expression<int>? id,
    Expression<int>? source_wallet_id,
    Expression<int>? target_wallet_id,
    Expression<double>? amount,
    Expression<DateTime>? transfer_date,
    Expression<String>? notes,
    Expression<DateTime>? created,
    Expression<DateTime>? updated_at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source_wallet_id != null) 'source_wallet_id': source_wallet_id,
      if (target_wallet_id != null) 'target_wallet_id': target_wallet_id,
      if (amount != null) 'amount': amount,
      if (transfer_date != null) 'transfer_date': transfer_date,
      if (notes != null) 'notes': notes,
      if (created != null) 'created': created,
      if (updated_at != null) 'updated_at': updated_at,
    });
  }

  TransfersCompanion copyWith({
    Value<int>? id,
    Value<int>? source_wallet_id,
    Value<int>? target_wallet_id,
    Value<double>? amount,
    Value<DateTime>? transfer_date,
    Value<String?>? notes,
    Value<DateTime>? created,
    Value<DateTime>? updated_at,
  }) {
    return TransfersCompanion(
      id: id ?? this.id,
      source_wallet_id: source_wallet_id ?? this.source_wallet_id,
      target_wallet_id: target_wallet_id ?? this.target_wallet_id,
      amount: amount ?? this.amount,
      transfer_date: transfer_date ?? this.transfer_date,
      notes: notes ?? this.notes,
      created: created ?? this.created,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (source_wallet_id.present) {
      map['source_wallet_id'] = Variable<int>(source_wallet_id.value);
    }
    if (target_wallet_id.present) {
      map['target_wallet_id'] = Variable<int>(target_wallet_id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transfer_date.present) {
      map['transfer_date'] = Variable<DateTime>(transfer_date.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated_at.present) {
      map['updated_at'] = Variable<DateTime>(updated_at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransfersCompanion(')
          ..write('id: $id, ')
          ..write('source_wallet_id: $source_wallet_id, ')
          ..write('target_wallet_id: $target_wallet_id, ')
          ..write('amount: $amount, ')
          ..write('transfer_date: $transfer_date, ')
          ..write('notes: $notes, ')
          ..write('created: $created, ')
          ..write('updated_at: $updated_at')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $WalletTable wallet = $WalletTable(this);
  late final $TransfersTable transfers = $TransfersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    transactions,
    wallet,
    transfers,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required int type,
      required DateTime created,
      required DateTime updated_at,
      Value<DateTime?> deleted_at,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> type,
      Value<DateTime> created,
      Value<DateTime> updated_at,
      Value<DateTime?> deleted_at,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => column,
  );
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated_at = const Value.absent(),
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                type: type,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int type,
                required DateTime created,
                required DateTime updated_at,
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                type: type,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required String name,
      required int category_id,
      required int wallet_id,
      required DateTime transaction_date,
      required int amount,
      required DateTime created,
      required DateTime updated_at,
      Value<DateTime?> deleted_at,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> category_id,
      Value<int> wallet_id,
      Value<DateTime> transaction_date,
      Value<int> amount,
      Value<DateTime> created,
      Value<DateTime> updated_at,
      Value<DateTime?> deleted_at,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category_id => $composableBuilder(
    column: $table.category_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wallet_id => $composableBuilder(
    column: $table.wallet_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transaction_date => $composableBuilder(
    column: $table.transaction_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category_id => $composableBuilder(
    column: $table.category_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wallet_id => $composableBuilder(
    column: $table.wallet_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transaction_date => $composableBuilder(
    column: $table.transaction_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get category_id => $composableBuilder(
    column: $table.category_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wallet_id =>
      $composableBuilder(column: $table.wallet_id, builder: (column) => column);

  GeneratedColumn<DateTime> get transaction_date => $composableBuilder(
    column: $table.transaction_date,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => column,
  );
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            Transaction,
            BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
          ),
          Transaction,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> category_id = const Value.absent(),
                Value<int> wallet_id = const Value.absent(),
                Value<DateTime> transaction_date = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated_at = const Value.absent(),
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                name: name,
                category_id: category_id,
                wallet_id: wallet_id,
                transaction_date: transaction_date,
                amount: amount,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int category_id,
                required int wallet_id,
                required DateTime transaction_date,
                required int amount,
                required DateTime created,
                required DateTime updated_at,
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                name: name,
                category_id: category_id,
                wallet_id: wallet_id,
                transaction_date: transaction_date,
                amount: amount,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        Transaction,
        BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
      ),
      Transaction,
      PrefetchHooks Function()
    >;
typedef $$WalletTableCreateCompanionBuilder =
    WalletCompanion Function({
      Value<int> id,
      required String name,
      Value<double> balance,
      required DateTime created,
      required DateTime updated_at,
      Value<DateTime?> deleted_at,
    });
typedef $$WalletTableUpdateCompanionBuilder =
    WalletCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> balance,
      Value<DateTime> created,
      Value<DateTime> updated_at,
      Value<DateTime?> deleted_at,
    });

class $$WalletTableFilterComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deleted_at => $composableBuilder(
    column: $table.deleted_at,
    builder: (column) => column,
  );
}

class $$WalletTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletTable,
          WalletData,
          $$WalletTableFilterComposer,
          $$WalletTableOrderingComposer,
          $$WalletTableAnnotationComposer,
          $$WalletTableCreateCompanionBuilder,
          $$WalletTableUpdateCompanionBuilder,
          (WalletData, BaseReferences<_$AppDatabase, $WalletTable, WalletData>),
          WalletData,
          PrefetchHooks Function()
        > {
  $$WalletTableTableManager(_$AppDatabase db, $WalletTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated_at = const Value.absent(),
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => WalletCompanion(
                id: id,
                name: name,
                balance: balance,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<double> balance = const Value.absent(),
                required DateTime created,
                required DateTime updated_at,
                Value<DateTime?> deleted_at = const Value.absent(),
              }) => WalletCompanion.insert(
                id: id,
                name: name,
                balance: balance,
                created: created,
                updated_at: updated_at,
                deleted_at: deleted_at,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletTable,
      WalletData,
      $$WalletTableFilterComposer,
      $$WalletTableOrderingComposer,
      $$WalletTableAnnotationComposer,
      $$WalletTableCreateCompanionBuilder,
      $$WalletTableUpdateCompanionBuilder,
      (WalletData, BaseReferences<_$AppDatabase, $WalletTable, WalletData>),
      WalletData,
      PrefetchHooks Function()
    >;
typedef $$TransfersTableCreateCompanionBuilder =
    TransfersCompanion Function({
      Value<int> id,
      required int source_wallet_id,
      required int target_wallet_id,
      required double amount,
      required DateTime transfer_date,
      Value<String?> notes,
      required DateTime created,
      required DateTime updated_at,
    });
typedef $$TransfersTableUpdateCompanionBuilder =
    TransfersCompanion Function({
      Value<int> id,
      Value<int> source_wallet_id,
      Value<int> target_wallet_id,
      Value<double> amount,
      Value<DateTime> transfer_date,
      Value<String?> notes,
      Value<DateTime> created,
      Value<DateTime> updated_at,
    });

class $$TransfersTableFilterComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get source_wallet_id => $composableBuilder(
    column: $table.source_wallet_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target_wallet_id => $composableBuilder(
    column: $table.target_wallet_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transfer_date => $composableBuilder(
    column: $table.transfer_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source_wallet_id => $composableBuilder(
    column: $table.source_wallet_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target_wallet_id => $composableBuilder(
    column: $table.target_wallet_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transfer_date => $composableBuilder(
    column: $table.transfer_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get source_wallet_id => $composableBuilder(
    column: $table.source_wallet_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get target_wallet_id => $composableBuilder(
    column: $table.target_wallet_id,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get transfer_date => $composableBuilder(
    column: $table.transfer_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated_at => $composableBuilder(
    column: $table.updated_at,
    builder: (column) => column,
  );
}

class $$TransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransfersTable,
          Transfer,
          $$TransfersTableFilterComposer,
          $$TransfersTableOrderingComposer,
          $$TransfersTableAnnotationComposer,
          $$TransfersTableCreateCompanionBuilder,
          $$TransfersTableUpdateCompanionBuilder,
          (Transfer, BaseReferences<_$AppDatabase, $TransfersTable, Transfer>),
          Transfer,
          PrefetchHooks Function()
        > {
  $$TransfersTableTableManager(_$AppDatabase db, $TransfersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> source_wallet_id = const Value.absent(),
                Value<int> target_wallet_id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> transfer_date = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated_at = const Value.absent(),
              }) => TransfersCompanion(
                id: id,
                source_wallet_id: source_wallet_id,
                target_wallet_id: target_wallet_id,
                amount: amount,
                transfer_date: transfer_date,
                notes: notes,
                created: created,
                updated_at: updated_at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int source_wallet_id,
                required int target_wallet_id,
                required double amount,
                required DateTime transfer_date,
                Value<String?> notes = const Value.absent(),
                required DateTime created,
                required DateTime updated_at,
              }) => TransfersCompanion.insert(
                id: id,
                source_wallet_id: source_wallet_id,
                target_wallet_id: target_wallet_id,
                amount: amount,
                transfer_date: transfer_date,
                notes: notes,
                created: created,
                updated_at: updated_at,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransfersTable,
      Transfer,
      $$TransfersTableFilterComposer,
      $$TransfersTableOrderingComposer,
      $$TransfersTableAnnotationComposer,
      $$TransfersTableCreateCompanionBuilder,
      $$TransfersTableUpdateCompanionBuilder,
      (Transfer, BaseReferences<_$AppDatabase, $TransfersTable, Transfer>),
      Transfer,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$WalletTableTableManager get wallet =>
      $$WalletTableTableManager(_db, _db.wallet);
  $$TransfersTableTableManager get transfers =>
      $$TransfersTableTableManager(_db, _db.transfers);
}
