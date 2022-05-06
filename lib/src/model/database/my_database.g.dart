// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PeoplesTableData extends DataClass
    implements Insertable<PeoplesTableData> {
  final String id;
  final String name;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  PeoplesTableData(
      {required this.id,
      required this.name,
      this.imagePath,
      this.createdAt,
      this.updatedAt});
  factory PeoplesTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PeoplesTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      imagePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String?>(imagePath);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime?>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    return map;
  }

  PeoplesTableCompanion toCompanion(bool nullToAbsent) {
    return PeoplesTableCompanion(
      id: Value(id),
      name: Value(name),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PeoplesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeoplesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String?>(imagePath),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PeoplesTableData copyWith(
          {String? id,
          String? name,
          String? imagePath,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PeoplesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PeoplesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imagePath, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeoplesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PeoplesTableCompanion extends UpdateCompanion<PeoplesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> imagePath;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const PeoplesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PeoplesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PeoplesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String?>? imagePath,
    Expression<DateTime?>? createdAt,
    Expression<DateTime?>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PeoplesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? imagePath,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return PeoplesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String?>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime?>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
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
          ..write('updatedAt: $updatedAt')
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
  late final GeneratedColumn<String?> imagePath = GeneratedColumn<String?>(
      'image_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, imagePath, createdAt, updatedAt];
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
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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

class TransactionTableData extends DataClass
    implements Insertable<TransactionTableData> {
  final String id;
  final String peopleId;
  final String title;
  final int amount;
  final DateTime loanDate;
  final DateTime? returnDate;
  final String? description;
  final String? attachmentPath;
  final String paymentStatus;
  final String transactionType;
  final DateTime createdAt;
  final DateTime? updatedAt;
  TransactionTableData(
      {required this.id,
      required this.peopleId,
      required this.title,
      required this.amount,
      required this.loanDate,
      this.returnDate,
      this.description,
      this.attachmentPath,
      required this.paymentStatus,
      required this.transactionType,
      required this.createdAt,
      this.updatedAt});
  factory TransactionTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TransactionTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      peopleId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}people_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      loanDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}loan_date'])!,
      returnDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_date']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      attachmentPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment_path']),
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      transactionType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_type'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['people_id'] = Variable<String>(peopleId);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<int>(amount);
    map['loan_date'] = Variable<DateTime>(loanDate);
    if (!nullToAbsent || returnDate != null) {
      map['return_date'] = Variable<DateTime?>(returnDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || attachmentPath != null) {
      map['attachment_path'] = Variable<String?>(attachmentPath);
    }
    map['payment_status'] = Variable<String>(paymentStatus);
    map['transaction_type'] = Variable<String>(transactionType);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      peopleId: Value(peopleId),
      title: Value(title),
      amount: Value(amount),
      loanDate: Value(loanDate),
      returnDate: returnDate == null && nullToAbsent
          ? const Value.absent()
          : Value(returnDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      attachmentPath: attachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentPath),
      paymentStatus: Value(paymentStatus),
      transactionType: Value(transactionType),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory TransactionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTableData(
      id: serializer.fromJson<String>(json['id']),
      peopleId: serializer.fromJson<String>(json['peopleId']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<int>(json['amount']),
      loanDate: serializer.fromJson<DateTime>(json['loanDate']),
      returnDate: serializer.fromJson<DateTime?>(json['returnDate']),
      description: serializer.fromJson<String?>(json['description']),
      attachmentPath: serializer.fromJson<String?>(json['attachmentPath']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
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
      'loanDate': serializer.toJson<DateTime>(loanDate),
      'returnDate': serializer.toJson<DateTime?>(returnDate),
      'description': serializer.toJson<String?>(description),
      'attachmentPath': serializer.toJson<String?>(attachmentPath),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'transactionType': serializer.toJson<String>(transactionType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  TransactionTableData copyWith(
          {String? id,
          String? peopleId,
          String? title,
          int? amount,
          DateTime? loanDate,
          DateTime? returnDate,
          String? description,
          String? attachmentPath,
          String? paymentStatus,
          String? transactionType,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TransactionTableData(
        id: id ?? this.id,
        peopleId: peopleId ?? this.peopleId,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        loanDate: loanDate ?? this.loanDate,
        returnDate: returnDate ?? this.returnDate,
        description: description ?? this.description,
        attachmentPath: attachmentPath ?? this.attachmentPath,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        transactionType: transactionType ?? this.transactionType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionTableData(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('loanDate: $loanDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('description: $description, ')
          ..write('attachmentPath: $attachmentPath, ')
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
      loanDate,
      returnDate,
      description,
      attachmentPath,
      paymentStatus,
      transactionType,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionTableData &&
          other.id == this.id &&
          other.peopleId == this.peopleId &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.loanDate == this.loanDate &&
          other.returnDate == this.returnDate &&
          other.description == this.description &&
          other.attachmentPath == this.attachmentPath &&
          other.paymentStatus == this.paymentStatus &&
          other.transactionType == this.transactionType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionTableCompanion extends UpdateCompanion<TransactionTableData> {
  final Value<String> id;
  final Value<String> peopleId;
  final Value<String> title;
  final Value<int> amount;
  final Value<DateTime> loanDate;
  final Value<DateTime?> returnDate;
  final Value<String?> description;
  final Value<String?> attachmentPath;
  final Value<String> paymentStatus;
  final Value<String> transactionType;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.loanDate = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.description = const Value.absent(),
    this.attachmentPath = const Value.absent(),
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
    required DateTime loanDate,
    this.returnDate = const Value.absent(),
    this.description = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    required String paymentStatus,
    required String transactionType,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : title = Value(title),
        amount = Value(amount),
        loanDate = Value(loanDate),
        paymentStatus = Value(paymentStatus),
        transactionType = Value(transactionType),
        createdAt = Value(createdAt);
  static Insertable<TransactionTableData> custom({
    Expression<String>? id,
    Expression<String>? peopleId,
    Expression<String>? title,
    Expression<int>? amount,
    Expression<DateTime>? loanDate,
    Expression<DateTime?>? returnDate,
    Expression<String?>? description,
    Expression<String?>? attachmentPath,
    Expression<String>? paymentStatus,
    Expression<String>? transactionType,
    Expression<DateTime>? createdAt,
    Expression<DateTime?>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (peopleId != null) 'people_id': peopleId,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (loanDate != null) 'loan_date': loanDate,
      if (returnDate != null) 'return_date': returnDate,
      if (description != null) 'description': description,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
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
      Value<DateTime>? loanDate,
      Value<DateTime?>? returnDate,
      Value<String?>? description,
      Value<String?>? attachmentPath,
      Value<String>? paymentStatus,
      Value<String>? transactionType,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
      description: description ?? this.description,
      attachmentPath: attachmentPath ?? this.attachmentPath,
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
    if (loanDate.present) {
      map['loan_date'] = Variable<DateTime>(loanDate.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime?>(returnDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (attachmentPath.present) {
      map['attachment_path'] = Variable<String?>(attachmentPath.value);
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
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
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
          ..write('loanDate: $loanDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('description: $description, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('transactionType: $transactionType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TransactionTableData> {
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
  final VerificationMeta _loanDateMeta = const VerificationMeta('loanDate');
  @override
  late final GeneratedColumn<DateTime?> loanDate = GeneratedColumn<DateTime?>(
      'loan_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _returnDateMeta = const VerificationMeta('returnDate');
  @override
  late final GeneratedColumn<DateTime?> returnDate = GeneratedColumn<DateTime?>(
      'return_date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _attachmentPathMeta =
      const VerificationMeta('attachmentPath');
  @override
  late final GeneratedColumn<String?> attachmentPath = GeneratedColumn<String?>(
      'attachment_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
      'updated_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        peopleId,
        title,
        amount,
        loanDate,
        returnDate,
        description,
        attachmentPath,
        paymentStatus,
        transactionType,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'transaction_table';
  @override
  String get actualTableName => 'transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionTableData> instance,
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
    if (data.containsKey('loan_date')) {
      context.handle(_loanDateMeta,
          loanDate.isAcceptableOrUnknown(data['loan_date']!, _loanDateMeta));
    } else if (isInserting) {
      context.missing(_loanDateMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
          _returnDateMeta,
          returnDate.isAcceptableOrUnknown(
              data['return_date']!, _returnDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('attachment_path')) {
      context.handle(
          _attachmentPathMeta,
          attachmentPath.isAcceptableOrUnknown(
              data['attachment_path']!, _attachmentPathMeta));
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TransactionTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class PaymentTableData extends DataClass
    implements Insertable<PaymentTableData> {
  final String id;
  final String peopleId;
  final String transactionId;
  final int amount;
  final DateTime date;
  final String? description;
  final String? attachmentPath;
  final DateTime createdAt;
  final DateTime? updatedAt;
  PaymentTableData(
      {required this.id,
      required this.peopleId,
      required this.transactionId,
      required this.amount,
      required this.date,
      this.description,
      this.attachmentPath,
      required this.createdAt,
      this.updatedAt});
  factory PaymentTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PaymentTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      peopleId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}people_id'])!,
      transactionId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      attachmentPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment_path']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['people_id'] = Variable<String>(peopleId);
    map['transaction_id'] = Variable<String>(transactionId);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || attachmentPath != null) {
      map['attachment_path'] = Variable<String?>(attachmentPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    return map;
  }

  PaymentTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentTableCompanion(
      id: Value(id),
      peopleId: Value(peopleId),
      transactionId: Value(transactionId),
      amount: Value(amount),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      attachmentPath: attachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentPath),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PaymentTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentTableData(
      id: serializer.fromJson<String>(json['id']),
      peopleId: serializer.fromJson<String>(json['peopleId']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      attachmentPath: serializer.fromJson<String?>(json['attachmentPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
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
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'attachmentPath': serializer.toJson<String?>(attachmentPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PaymentTableData copyWith(
          {String? id,
          String? peopleId,
          String? transactionId,
          int? amount,
          DateTime? date,
          String? description,
          String? attachmentPath,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PaymentTableData(
        id: id ?? this.id,
        peopleId: peopleId ?? this.peopleId,
        transactionId: transactionId ?? this.transactionId,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        description: description ?? this.description,
        attachmentPath: attachmentPath ?? this.attachmentPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PaymentTableData(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, peopleId, transactionId, amount, date,
      description, attachmentPath, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentTableData &&
          other.id == this.id &&
          other.peopleId == this.peopleId &&
          other.transactionId == this.transactionId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.attachmentPath == this.attachmentPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentTableCompanion extends UpdateCompanion<PaymentTableData> {
  final Value<String> id;
  final Value<String> peopleId;
  final Value<String> transactionId;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<String?> attachmentPath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const PaymentTableCompanion({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PaymentTableCompanion.insert({
    this.id = const Value.absent(),
    this.peopleId = const Value.absent(),
    this.transactionId = const Value.absent(),
    required int amount,
    required DateTime date,
    this.description = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : amount = Value(amount),
        date = Value(date),
        createdAt = Value(createdAt);
  static Insertable<PaymentTableData> custom({
    Expression<String>? id,
    Expression<String>? peopleId,
    Expression<String>? transactionId,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String?>? description,
    Expression<String?>? attachmentPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime?>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (peopleId != null) 'people_id': peopleId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PaymentTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? peopleId,
      Value<String>? transactionId,
      Value<int>? amount,
      Value<DateTime>? date,
      Value<String?>? description,
      Value<String?>? attachmentPath,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return PaymentTableCompanion(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      attachmentPath: attachmentPath ?? this.attachmentPath,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (attachmentPath.present) {
      map['attachment_path'] = Variable<String?>(attachmentPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentTableCompanion(')
          ..write('id: $id, ')
          ..write('peopleId: $peopleId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentTableTable extends PaymentTable
    with TableInfo<$PaymentTableTable, PaymentTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTableTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints: 'REFERENCES transaction_table (id) ON DELETE CASCADE',
      clientDefault: () => const Uuid().v4());
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
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _attachmentPathMeta =
      const VerificationMeta('attachmentPath');
  @override
  late final GeneratedColumn<String?> attachmentPath = GeneratedColumn<String?>(
      'attachment_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        peopleId,
        transactionId,
        amount,
        date,
        description,
        attachmentPath,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'payment';
  @override
  String get actualTableName => 'payment';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentTableData> instance,
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
    }
    if (data.containsKey('attachment_path')) {
      context.handle(
          _attachmentPathMeta,
          attachmentPath.isAcceptableOrUnknown(
              data['attachment_path']!, _attachmentPathMeta));
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PaymentTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PaymentTableTable createAlias(String alias) {
    return $PaymentTableTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PeoplesTableTable peoplesTable = $PeoplesTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $PaymentTableTable paymentTable = $PaymentTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [peoplesTable, transactionTable, paymentTable];
}
