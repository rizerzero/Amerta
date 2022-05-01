// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PeoplesTableData extends DataClass
    implements Insertable<PeoplesTableData> {
  final String id;
  final String name;
  final Uint8List imagePath;
  final DateTime createdAt;
  final DateTime updatedA;
  PeoplesTableData(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.createdAt,
      required this.updatedA});
  factory PeoplesTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PeoplesTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      imagePath: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedA: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_a'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['image_path'] = Variable<Uint8List>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_a'] = Variable<DateTime>(updatedA);
    return map;
  }

  PeoplesTableCompanion toCompanion(bool nullToAbsent) {
    return PeoplesTableCompanion(
      id: Value(id),
      name: Value(name),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
      updatedA: Value(updatedA),
    );
  }

  factory PeoplesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeoplesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<Uint8List>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedA: serializer.fromJson<DateTime>(json['updatedA']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<Uint8List>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedA': serializer.toJson<DateTime>(updatedA),
    };
  }

  PeoplesTableData copyWith(
          {String? id,
          String? name,
          Uint8List? imagePath,
          DateTime? createdAt,
          DateTime? updatedA}) =>
      PeoplesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        createdAt: createdAt ?? this.createdAt,
        updatedA: updatedA ?? this.updatedA,
      );
  @override
  String toString() {
    return (StringBuffer('PeoplesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedA: $updatedA')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imagePath, createdAt, updatedA);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeoplesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt &&
          other.updatedA == this.updatedA);
}

class PeoplesTableCompanion extends UpdateCompanion<PeoplesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<Uint8List> imagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedA;
  const PeoplesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedA = const Value.absent(),
  });
  PeoplesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Uint8List imagePath,
    required DateTime createdAt,
    required DateTime updatedA,
  })  : name = Value(name),
        imagePath = Value(imagePath),
        createdAt = Value(createdAt),
        updatedA = Value(updatedA);
  static Insertable<PeoplesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<Uint8List>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedA,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedA != null) 'updated_a': updatedA,
    });
  }

  PeoplesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<Uint8List>? imagePath,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedA}) {
    return PeoplesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedA: updatedA ?? this.updatedA,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<Uint8List>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedA.present) {
      map['updated_a'] = Variable<DateTime>(updatedA.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeoplesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedA: $updatedA')
          ..write(')'))
        .toString();
  }
}

class $PeoplesTableTable extends PeoplesTable
    with TableInfo<$PeoplesTableTable, PeoplesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeoplesTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<Uint8List?> imagePath =
      GeneratedColumn<Uint8List?>('image_path', aliasedName, false,
          type: const BlobType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAMeta = const VerificationMeta('updatedA');
  @override
  late final GeneratedColumn<DateTime?> updatedA = GeneratedColumn<DateTime?>(
      'updated_a', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, imagePath, createdAt, updatedA];
  @override
  String get aliasedName => _alias ?? 'people';
  @override
  String get actualTableName => 'people';
  @override
  VerificationContext validateIntegrity(Insertable<PeoplesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_a')) {
      context.handle(_updatedAMeta,
          updatedA.isAcceptableOrUnknown(data['updated_a']!, _updatedAMeta));
    } else if (isInserting) {
      context.missing(_updatedAMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  PeoplesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PeoplesTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PeoplesTableTable createAlias(String alias) {
    return $PeoplesTableTable(attachedDatabase, alias);
  }
}

class transaction extends DataClass implements Insertable<transaction> {
  final String id;
  final String peopleId;
  final String title;
  final int amount;
  final DateTime date;
  final String description;
  final Uint8List attachment;
  final String paymentStatus;
  final String transactionType;
  final DateTime createdAt;
  final DateTime updatedAt;
  transaction(
      {required this.id,
      required this.peopleId,
      required this.title,
      required this.amount,
      required this.date,
      required this.description,
      required this.attachment,
      required this.paymentStatus,
      required this.transactionType,
      required this.createdAt,
      required this.updatedAt});
  factory transaction.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return transaction(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      peopleId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}people_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      attachment: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment'])!,
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      transactionType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_type'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['people_id'] = Variable<String>(peopleId);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['attachment'] = Variable<Uint8List>(attachment);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['transaction_type'] = Variable<String>(transactionType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      peopleId: Value(peopleId),
      title: Value(title),
      amount: Value(amount),
      date: Value(date),
      description: Value(description),
      attachment: Value(attachment),
      paymentStatus: Value(paymentStatus),
      transactionType: Value(transactionType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return transaction(
      id: serializer.fromJson<String>(json['id']),
      peopleId: serializer.fromJson<String>(json['peopleId']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      attachment: serializer.fromJson<Uint8List>(json['attachment']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'peopleId': serializer.toJson<String>(peopleId),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'attachment': serializer.toJson<Uint8List>(attachment),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'transactionType': serializer.toJson<String>(transactionType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  transaction copyWith(
          {String? id,
          String? peopleId,
          String? title,
          int? amount,
          DateTime? date,
          String? description,
          Uint8List? attachment,
          String? paymentStatus,
          String? transactionType,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      transaction(
        id: id ?? this.id,
        peopleId: peopleId ?? this.peopleId,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        description: description ?? this.description,
        attachment: attachment ?? this.attachment,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        transactionType: transactionType ?? this.transactionType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('transaction(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('attachment: $attachment, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('transactionType: $transactionType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      peopleId,
      title,
      amount,
      date,
      description,
      attachment,
      paymentStatus,
      transactionType,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is transaction &&
          other.id == this.id &&
          other.peopleId == this.peopleId &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.attachment == this.attachment &&
          other.paymentStatus == this.paymentStatus &&
          other.transactionType == this.transactionType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionTableCompanion extends UpdateCompanion<transaction> {
  final Value<String> id;
  final Value<String> peopleId;
  final Value<String> title;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<Uint8List> attachment;
  final Value<String> paymentStatus;
  final Value<String> transactionType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.attachment = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    required String title,
    required int amount,
    required DateTime date,
    required String description,
    required Uint8List attachment,
    required String paymentStatus,
    required String transactionType,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : title = Value(title),
        amount = Value(amount),
        date = Value(date),
        description = Value(description),
        attachment = Value(attachment),
        paymentStatus = Value(paymentStatus),
        transactionType = Value(transactionType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<transaction> custom({
    Expression<String>? id,
    Expression<String>? peopleId,
    Expression<String>? title,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<Uint8List>? attachment,
    Expression<String>? paymentStatus,
    Expression<String>? transactionType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (peopleId != null) 'people_id': peopleId,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (attachment != null) 'attachment': attachment,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (transactionType != null) 'transaction_type': transactionType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? peopleId,
      Value<String>? title,
      Value<int>? amount,
      Value<DateTime>? date,
      Value<String>? description,
      Value<Uint8List>? attachment,
      Value<String>? paymentStatus,
      Value<String>? transactionType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (peopleId.present) {
      map['people_id'] = Variable<String>(peopleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (attachment.present) {
      map['attachment'] = Variable<Uint8List>(attachment.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('attachment: $attachment, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('transactionType: $transactionType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _peopleIdMeta = const VerificationMeta('peopleId');
  @override
  late final GeneratedColumn<String?> peopleId = GeneratedColumn<String?>(
      'people_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES people (id) ON DELETE CASCADE',
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _attachmentMeta = const VerificationMeta('attachment');
  @override
  late final GeneratedColumn<Uint8List?> attachment =
      GeneratedColumn<Uint8List?>('attachment', aliasedName, false,
          type: const BlobType(), requiredDuringInsert: true);
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String?> paymentStatus = GeneratedColumn<String?>(
      'payment_status', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _transactionTypeMeta =
      const VerificationMeta('transactionType');
  @override
  late final GeneratedColumn<String?> transactionType =
      GeneratedColumn<String?>('transaction_type', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        peopleId,
        title,
        amount,
        date,
        description,
        attachment,
        paymentStatus,
        transactionType,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'transaction';
  @override
  String get actualTableName => 'transaction';
  @override
  VerificationContext validateIntegrity(Insertable<transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('people_id')) {
      context.handle(_peopleIdMeta,
          peopleId.isAcceptableOrUnknown(data['people_id']!, _peopleIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('attachment')) {
      context.handle(
          _attachmentMeta,
          attachment.isAcceptableOrUnknown(
              data['attachment']!, _attachmentMeta));
    } else if (isInserting) {
      context.missing(_attachmentMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
          _transactionTypeMeta,
          transactionType.isAcceptableOrUnknown(
              data['transaction_type']!, _transactionTypeMeta));
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    return transaction.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class TransactionDetailTableData extends DataClass
    implements Insertable<TransactionDetailTableData> {
  final String id;
  final String peopleId;
  final String transactionId;
  final int amount;
  final String description;
  final Uint8List attachment;
  final DateTime createdAt;
  final DateTime updatedAt;
  TransactionDetailTableData(
      {required this.id,
      required this.peopleId,
      required this.transactionId,
      required this.amount,
      required this.description,
      required this.attachment,
      required this.createdAt,
      required this.updatedAt});
  factory TransactionDetailTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TransactionDetailTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      peopleId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}people_id'])!,
      transactionId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      attachment: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['people_id'] = Variable<String>(peopleId);
    map['transaction_id'] = Variable<String>(transactionId);
    map['amount'] = Variable<int>(amount);
    map['description'] = Variable<String>(description);
    map['attachment'] = Variable<Uint8List>(attachment);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionDetailTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionDetailTableCompanion(
      id: Value(id),
      peopleId: Value(peopleId),
      transactionId: Value(transactionId),
      amount: Value(amount),
      description: Value(description),
      attachment: Value(attachment),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionDetailTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDetailTableData(
      id: serializer.fromJson<String>(json['id']),
      peopleId: serializer.fromJson<String>(json['peopleId']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      amount: serializer.fromJson<int>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      attachment: serializer.fromJson<Uint8List>(json['attachment']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'peopleId': serializer.toJson<String>(peopleId),
      'transactionId': serializer.toJson<String>(transactionId),
      'amount': serializer.toJson<int>(amount),
      'description': serializer.toJson<String>(description),
      'attachment': serializer.toJson<Uint8List>(attachment),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionDetailTableData copyWith(
          {String? id,
          String? peopleId,
          String? transactionId,
          int? amount,
          String? description,
          Uint8List? attachment,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TransactionDetailTableData(
        id: id ?? this.id,
        peopleId: peopleId ?? this.peopleId,
        transactionId: transactionId ?? this.transactionId,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        attachment: attachment ?? this.attachment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDetailTableData(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('attachment: $attachment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, peopleId, transactionId, amount,
      description, attachment, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDetailTableData &&
          other.id == this.id &&
          other.peopleId == this.peopleId &&
          other.transactionId == this.transactionId &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.attachment == this.attachment &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionDetailTableCompanion
    extends UpdateCompanion<TransactionDetailTableData> {
  final Value<String> id;
  final Value<String> peopleId;
  final Value<String> transactionId;
  final Value<int> amount;
  final Value<String> description;
  final Value<Uint8List> attachment;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TransactionDetailTableCompanion({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.attachment = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionDetailTableCompanion.insert({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.transactionId = const Value.absent(),
    required int amount,
    required String description,
    required Uint8List attachment,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : amount = Value(amount),
        description = Value(description),
        attachment = Value(attachment),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TransactionDetailTableData> custom({
    Expression<String>? id,
    Expression<String>? peopleId,
    Expression<String>? transactionId,
    Expression<int>? amount,
    Expression<String>? description,
    Expression<Uint8List>? attachment,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (peopleId != null) 'people_id': peopleId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (attachment != null) 'attachment': attachment,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionDetailTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? peopleId,
      Value<String>? transactionId,
      Value<int>? amount,
      Value<String>? description,
      Value<Uint8List>? attachment,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TransactionDetailTableCompanion(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (peopleId.present) {
      map['people_id'] = Variable<String>(peopleId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (attachment.present) {
      map['attachment'] = Variable<Uint8List>(attachment.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionDetailTableCompanion(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('attachment: $attachment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionDetailTableTable extends TransactionDetailTable
    with TableInfo<$TransactionDetailTableTable, TransactionDetailTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionDetailTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _peopleIdMeta = const VerificationMeta('peopleId');
  @override
  late final GeneratedColumn<String?> peopleId = GeneratedColumn<String?>(
      'people_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES people (id) ON DELETE CASCADE',
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String?> transactionId = GeneratedColumn<String?>(
      'transaction_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "transaction" (id) ON DELETE CASCADE',
      clientDefault: () => const Uuid().v4());
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _attachmentMeta = const VerificationMeta('attachment');
  @override
  late final GeneratedColumn<Uint8List?> attachment =
      GeneratedColumn<Uint8List?>('attachment', aliasedName, false,
          type: const BlobType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        peopleId,
        transactionId,
        amount,
        description,
        attachment,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'transaction_detail';
  @override
  String get actualTableName => 'transaction_detail';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionDetailTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('people_id')) {
      context.handle(_peopleIdMeta,
          peopleId.isAcceptableOrUnknown(data['people_id']!, _peopleIdMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('attachment')) {
      context.handle(
          _attachmentMeta,
          attachment.isAcceptableOrUnknown(
              data['attachment']!, _attachmentMeta));
    } else if (isInserting) {
      context.missing(_attachmentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  TransactionDetailTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return TransactionDetailTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionDetailTableTable createAlias(String alias) {
    return $TransactionDetailTableTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PeoplesTableTable peoplesTable = $PeoplesTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $TransactionDetailTableTable transactionDetailTable =
      $TransactionDetailTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [peoplesTable, transactionTable, transactionDetailTable];
}
