// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String login;
  final String phone;
  final String firstName;
  final String lastName;
  final String email;
  final bool activated;
  final String langKey;
  final List<dynamic>? authorities;
  Account(
      {required this.id,
      required this.login,
      required this.phone,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.activated,
      required this.langKey,
      required this.authorities});
  factory Account.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Account(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      login: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}login'])!,
      phone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      activated: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}activated'])!,
      langKey: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lang_key'])!,
      authorities: $AccountsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}authorities']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['login'] = Variable<String>(login);
    map['phone'] = Variable<String>(phone);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['activated'] = Variable<bool>(activated);
    map['lang_key'] = Variable<String>(langKey);
    {
      final converter = $AccountsTable.$converter0;
      map['authorities'] = Variable<String>(converter.mapToSql(authorities)!);
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      login: Value(login),
      phone: Value(phone),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      activated: Value(activated),
      langKey: Value(langKey),
      authorities: Value(authorities),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      login: serializer.fromJson<String>(json['login']),
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      activated: serializer.fromJson<bool>(json['activated']),
      langKey: serializer.fromJson<String>(json['langKey']),
      authorities: serializer.fromJson<List<dynamic>?>(json['authorities']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'login': serializer.toJson<String>(login),
      'phone': serializer.toJson<String>(phone),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'activated': serializer.toJson<bool>(activated),
      'langKey': serializer.toJson<String>(langKey),
      'authorities': serializer.toJson<List<dynamic>?>(authorities),
    };
  }

  Account copyWith(
          {int? id,
          String? login,
          String? phone,
          String? firstName,
          String? lastName,
          String? email,
          bool? activated,
          String? langKey,
          List<dynamic>? authorities}) =>
      Account(
        id: id ?? this.id,
        login: login ?? this.login,
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        activated: activated ?? this.activated,
        langKey: langKey ?? this.langKey,
        authorities: authorities ?? this.authorities,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('activated: $activated, ')
          ..write('langKey: $langKey, ')
          ..write('authorities: $authorities')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, login, phone, firstName, lastName, email,
      activated, langKey, authorities);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.login == this.login &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.activated == this.activated &&
          other.langKey == this.langKey &&
          other.authorities == this.authorities);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String> login;
  final Value<String> phone;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<bool> activated;
  final Value<String> langKey;
  final Value<List<dynamic>?> authorities;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.activated = const Value.absent(),
    this.langKey = const Value.absent(),
    this.authorities = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String login,
    required String phone,
    required String firstName,
    required String lastName,
    required String email,
    required bool activated,
    required String langKey,
    required List<dynamic>? authorities,
  })  : login = Value(login),
        phone = Value(phone),
        firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        activated = Value(activated),
        langKey = Value(langKey),
        authorities = Value(authorities);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? login,
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<bool>? activated,
    Expression<String>? langKey,
    Expression<List<dynamic>?>? authorities,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (activated != null) 'activated': activated,
      if (langKey != null) 'lang_key': langKey,
      if (authorities != null) 'authorities': authorities,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<String>? login,
      Value<String>? phone,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? email,
      Value<bool>? activated,
      Value<String>? langKey,
      Value<List<dynamic>?>? authorities}) {
    return AccountsCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      activated: activated ?? this.activated,
      langKey: langKey ?? this.langKey,
      authorities: authorities ?? this.authorities,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (activated.present) {
      map['activated'] = Variable<bool>(activated.value);
    }
    if (langKey.present) {
      map['lang_key'] = Variable<String>(langKey.value);
    }
    if (authorities.present) {
      final converter = $AccountsTable.$converter0;
      map['authorities'] =
          Variable<String>(converter.mapToSql(authorities.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('activated: $activated, ')
          ..write('langKey: $langKey, ')
          ..write('authorities: $authorities')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String?> login = GeneratedColumn<String?>(
      'login', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String?> phone = GeneratedColumn<String?>(
      'phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _activatedMeta = const VerificationMeta('activated');
  @override
  late final GeneratedColumn<bool?> activated = GeneratedColumn<bool?>(
      'activated', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (activated IN (0, 1))');
  final VerificationMeta _langKeyMeta = const VerificationMeta('langKey');
  @override
  late final GeneratedColumn<String?> langKey = GeneratedColumn<String?>(
      'lang_key', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _authoritiesMeta =
      const VerificationMeta('authorities');
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String?>
      authorities = GeneratedColumn<String?>('authorities', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<dynamic>?>($AccountsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        login,
        phone,
        firstName,
        lastName,
        email,
        activated,
        langKey,
        authorities
      ];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
          _loginMeta, login.isAcceptableOrUnknown(data['login']!, _loginMeta));
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('activated')) {
      context.handle(_activatedMeta,
          activated.isAcceptableOrUnknown(data['activated']!, _activatedMeta));
    } else if (isInserting) {
      context.missing(_activatedMeta);
    }
    if (data.containsKey('lang_key')) {
      context.handle(_langKeyMeta,
          langKey.isAcceptableOrUnknown(data['lang_key']!, _langKeyMeta));
    } else if (isInserting) {
      context.missing(_langKeyMeta);
    }
    context.handle(_authoritiesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Account.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>?, String> $converter0 =
      const ListingConverter();
}

class Trip extends DataClass implements Insertable<Trip> {
  final int id;
  Trip({required this.id});
  factory Trip.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Trip(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  Trip copyWith({int? id}) => Trip(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Trip && other.id == this.id);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<int> id;
  const TripsCompanion({
    this.id = const Value.absent(),
  });
  TripsCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<Trip> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  TripsCompanion copyWith({Value<int>? id}) {
    return TripsCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'trips';
  @override
  String get actualTableName => 'trips';
  @override
  VerificationContext validateIntegrity(Insertable<Trip> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Trip.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int id;
  Location({required this.id});
  factory Location.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Location(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  Location copyWith({int? id}) => Location(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Location && other.id == this.id);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  const LocationsCompanion({
    this.id = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<Location> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  LocationsCompanion copyWith({Value<int>? id}) {
    return LocationsCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'locations';
  @override
  String get actualTableName => 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Location.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String key;
  final String value;
  final String? extra;
  Session({required this.key, required this.value, this.extra});
  factory Session.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Session(
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      extra: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}extra']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String?>(extra);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      key: Value(key),
      value: Value(value),
      extra:
          extra == null && nullToAbsent ? const Value.absent() : Value(extra),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      extra: serializer.fromJson<String?>(json['extra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'extra': serializer.toJson<String?>(extra),
    };
  }

  Session copyWith({String? key, String? value, String? extra}) => Session(
        key: key ?? this.key,
        value: value ?? this.value,
        extra: extra ?? this.extra,
      );
  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('extra: $extra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, extra);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.key == this.key &&
          other.value == this.value &&
          other.extra == this.extra);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> key;
  final Value<String> value;
  final Value<String?> extra;
  const SessionsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.extra = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String key,
    required String value,
    this.extra = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Session> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String?>? extra,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (extra != null) 'extra': extra,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<String?>? extra}) {
    return SessionsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      extra: extra ?? this.extra,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String?>(extra.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('extra: $extra')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String?> extra = GeneratedColumn<String?>(
      'extra', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value, extra];
  @override
  String get aliasedName => _alias ?? 'sessions';
  @override
  String get actualTableName => 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Session.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [accounts, trips, locations, sessions];
}
