// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLandingCollection on Isar {
  IsarCollection<Landing> get landings => this.collection();
}

const LandingSchema = CollectionSchema(
  name: r'Landing',
  id: -6281180888650048977,
  properties: {
    r'boatName': PropertySchema(
      id: 0,
      name: r'boatName',
      type: IsarType.string,
    ),
    r'boatType': PropertySchema(
      id: 1,
      name: r'boatType',
      type: IsarType.string,
    ),
    r'catches': PropertySchema(
      id: 2,
      name: r'catches',
      type: IsarType.objectList,
      target: r'Catch',
    ),
    r'category': PropertySchema(
      id: 3,
      name: r'category',
      type: IsarType.string,
    ),
    r'community': PropertySchema(
      id: 4,
      name: r'community',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 5,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'fishermanName': PropertySchema(
      id: 6,
      name: r'fishermanName',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 7,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'landingPoint': PropertySchema(
      id: 8,
      name: r'landingPoint',
      type: IsarType.string,
    ),
    r'productionSource': PropertySchema(
      id: 9,
      name: r'productionSource',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 10,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _landingEstimateSize,
  serialize: _landingSerialize,
  deserialize: _landingDeserialize,
  deserializeProp: _landingDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Catch': CatchSchema},
  getId: _landingGetId,
  getLinks: _landingGetLinks,
  attach: _landingAttach,
  version: '3.1.0+1',
);

int _landingEstimateSize(
  Landing object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.boatName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.boatType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.catches.length * 3;
  {
    final offsets = allOffsets[Catch]!;
    for (var i = 0; i < object.catches.length; i++) {
      final value = object.catches[i];
      bytesCount += CatchSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.community;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fishermanName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.landingPoint;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productionSource;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _landingSerialize(
  Landing object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.boatName);
  writer.writeString(offsets[1], object.boatType);
  writer.writeObjectList<Catch>(
    offsets[2],
    allOffsets,
    CatchSchema.serialize,
    object.catches,
  );
  writer.writeString(offsets[3], object.category);
  writer.writeString(offsets[4], object.community);
  writer.writeDateTime(offsets[5], object.date);
  writer.writeString(offsets[6], object.fishermanName);
  writer.writeBool(offsets[7], object.isSynced);
  writer.writeString(offsets[8], object.landingPoint);
  writer.writeString(offsets[9], object.productionSource);
  writer.writeString(offsets[10], object.uuid);
}

Landing _landingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Landing();
  object.boatName = reader.readStringOrNull(offsets[0]);
  object.boatType = reader.readStringOrNull(offsets[1]);
  object.catches = reader.readObjectList<Catch>(
        offsets[2],
        CatchSchema.deserialize,
        allOffsets,
        Catch(),
      ) ??
      [];
  object.category = reader.readStringOrNull(offsets[3]);
  object.community = reader.readStringOrNull(offsets[4]);
  object.date = reader.readDateTime(offsets[5]);
  object.fishermanName = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[7]);
  object.landingPoint = reader.readStringOrNull(offsets[8]);
  object.productionSource = reader.readStringOrNull(offsets[9]);
  object.uuid = reader.readString(offsets[10]);
  return object;
}

P _landingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<Catch>(
            offset,
            CatchSchema.deserialize,
            allOffsets,
            Catch(),
          ) ??
          []) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _landingGetId(Landing object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _landingGetLinks(Landing object) {
  return [];
}

void _landingAttach(IsarCollection<dynamic> col, Id id, Landing object) {
  object.id = id;
}

extension LandingByIndex on IsarCollection<Landing> {
  Future<Landing?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Landing? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Landing?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Landing?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(Landing object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Landing object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Landing> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Landing> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension LandingQueryWhereSort on QueryBuilder<Landing, Landing, QWhere> {
  QueryBuilder<Landing, Landing, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LandingQueryWhere on QueryBuilder<Landing, Landing, QWhereClause> {
  QueryBuilder<Landing, Landing, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LandingQueryFilter
    on QueryBuilder<Landing, Landing, QFilterCondition> {
  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boatName',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boatName',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boatName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boatName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatName',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boatName',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boatType',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boatType',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boatType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boatType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatType',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> boatTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boatType',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      catchesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'catches',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'community',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'community',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'community',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'community',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'community',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> communityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'community',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fishermanName',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      fishermanNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fishermanName',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      fishermanNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fishermanName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fishermanName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> fishermanNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishermanName',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      fishermanNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fishermanName',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'landingPoint',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      landingPointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'landingPoint',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'landingPoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'landingPoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'landingPoint',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> landingPointIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'landingPoint',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      landingPointIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'landingPoint',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productionSource',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productionSource',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> productionSourceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> productionSourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productionSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productionSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> productionSourceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productionSource',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productionSource',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition>
      productionSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productionSource',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Landing, Landing, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension LandingQueryObject
    on QueryBuilder<Landing, Landing, QFilterCondition> {
  QueryBuilder<Landing, Landing, QAfterFilterCondition> catchesElement(
      FilterQuery<Catch> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'catches');
    });
  }
}

extension LandingQueryLinks
    on QueryBuilder<Landing, Landing, QFilterCondition> {}

extension LandingQuerySortBy on QueryBuilder<Landing, Landing, QSortBy> {
  QueryBuilder<Landing, Landing, QAfterSortBy> sortByBoatName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByBoatNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByBoatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByBoatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByCommunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByCommunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByFishermanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByFishermanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByLandingPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'landingPoint', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByLandingPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'landingPoint', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByProductionSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productionSource', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByProductionSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productionSource', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LandingQuerySortThenBy
    on QueryBuilder<Landing, Landing, QSortThenBy> {
  QueryBuilder<Landing, Landing, QAfterSortBy> thenByBoatName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByBoatNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByBoatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByBoatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByCommunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByCommunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByFishermanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByFishermanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByLandingPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'landingPoint', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByLandingPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'landingPoint', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByProductionSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productionSource', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByProductionSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productionSource', Sort.desc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Landing, Landing, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LandingQueryWhereDistinct
    on QueryBuilder<Landing, Landing, QDistinct> {
  QueryBuilder<Landing, Landing, QDistinct> distinctByBoatName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boatName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByBoatType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boatType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByCommunity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'community', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByFishermanName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fishermanName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByLandingPoint(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'landingPoint', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByProductionSource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productionSource',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Landing, Landing, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension LandingQueryProperty
    on QueryBuilder<Landing, Landing, QQueryProperty> {
  QueryBuilder<Landing, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> boatNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boatName');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> boatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boatType');
    });
  }

  QueryBuilder<Landing, List<Catch>, QQueryOperations> catchesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'catches');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> communityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'community');
    });
  }

  QueryBuilder<Landing, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> fishermanNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fishermanName');
    });
  }

  QueryBuilder<Landing, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> landingPointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'landingPoint');
    });
  }

  QueryBuilder<Landing, String?, QQueryOperations> productionSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productionSource');
    });
  }

  QueryBuilder<Landing, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CatchSchema = Schema(
  name: r'Catch',
  id: -7111541606443502394,
  properties: {
    r'fishingGear': PropertySchema(
      id: 0,
      name: r'fishingGear',
      type: IsarType.string,
    ),
    r'fishingGround': PropertySchema(
      id: 1,
      name: r'fishingGround',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 2,
      name: r'price',
      type: IsarType.double,
    ),
    r'processingType': PropertySchema(
      id: 3,
      name: r'processingType',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 4,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'speciesName': PropertySchema(
      id: 5,
      name: r'speciesName',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 6,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _catchEstimateSize,
  serialize: _catchSerialize,
  deserialize: _catchDeserialize,
  deserializeProp: _catchDeserializeProp,
);

int _catchEstimateSize(
  Catch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fishingGear;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fishingGround;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.processingType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.speciesName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.unit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _catchSerialize(
  Catch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fishingGear);
  writer.writeString(offsets[1], object.fishingGround);
  writer.writeDouble(offsets[2], object.price);
  writer.writeString(offsets[3], object.processingType);
  writer.writeDouble(offsets[4], object.quantity);
  writer.writeString(offsets[5], object.speciesName);
  writer.writeString(offsets[6], object.unit);
}

Catch _catchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Catch();
  object.fishingGear = reader.readStringOrNull(offsets[0]);
  object.fishingGround = reader.readStringOrNull(offsets[1]);
  object.price = reader.readDoubleOrNull(offsets[2]);
  object.processingType = reader.readStringOrNull(offsets[3]);
  object.quantity = reader.readDoubleOrNull(offsets[4]);
  object.speciesName = reader.readStringOrNull(offsets[5]);
  object.unit = reader.readStringOrNull(offsets[6]);
  return object;
}

P _catchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CatchQueryFilter on QueryBuilder<Catch, Catch, QFilterCondition> {
  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fishingGear',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fishingGear',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fishingGear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fishingGear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fishingGear',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishingGear',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fishingGear',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fishingGround',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fishingGround',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fishingGround',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fishingGround',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fishingGround',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishingGround',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> fishingGroundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fishingGround',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'processingType',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'processingType',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'processingType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'processingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'processingType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processingType',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> processingTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'processingType',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> quantityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speciesName',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speciesName',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speciesName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speciesName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speciesName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesName',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> speciesNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speciesName',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<Catch, Catch, QAfterFilterCondition> unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension CatchQueryObject on QueryBuilder<Catch, Catch, QFilterCondition> {}
