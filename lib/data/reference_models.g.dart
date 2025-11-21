// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSpeciesCollection on Isar {
  IsarCollection<Species> get species => this.collection();
}

const SpeciesSchema = CollectionSchema(
  name: r'Species',
  id: -1724512414814962385,
  properties: {
    r'defaultUnit': PropertySchema(
      id: 0,
      name: r'defaultUnit',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _speciesEstimateSize,
  serialize: _speciesSerialize,
  deserialize: _speciesDeserialize,
  deserializeProp: _speciesDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _speciesGetId,
  getLinks: _speciesGetLinks,
  attach: _speciesAttach,
  version: '3.1.0+1',
);

int _speciesEstimateSize(
  Species object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _speciesSerialize(
  Species object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.defaultUnit);
  writer.writeString(offsets[1], object.name);
}

Species _speciesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Species();
  object.defaultUnit = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  return object;
}

P _speciesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _speciesGetId(Species object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _speciesGetLinks(Species object) {
  return [];
}

void _speciesAttach(IsarCollection<dynamic> col, Id id, Species object) {
  object.id = id;
}

extension SpeciesQueryWhereSort on QueryBuilder<Species, Species, QWhere> {
  QueryBuilder<Species, Species, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Species, Species, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension SpeciesQueryWhere on QueryBuilder<Species, Species, QWhereClause> {
  QueryBuilder<Species, Species, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Species, Species, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> idBetween(
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

  QueryBuilder<Species, Species, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension SpeciesQueryFilter
    on QueryBuilder<Species, Species, QFilterCondition> {
  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultUnit',
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultUnit',
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> defaultUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition>
      defaultUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Species, Species, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Species, Species, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Species, Species, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Species, Species, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension SpeciesQueryObject
    on QueryBuilder<Species, Species, QFilterCondition> {}

extension SpeciesQueryLinks
    on QueryBuilder<Species, Species, QFilterCondition> {}

extension SpeciesQuerySortBy on QueryBuilder<Species, Species, QSortBy> {
  QueryBuilder<Species, Species, QAfterSortBy> sortByDefaultUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.asc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> sortByDefaultUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.desc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SpeciesQuerySortThenBy
    on QueryBuilder<Species, Species, QSortThenBy> {
  QueryBuilder<Species, Species, QAfterSortBy> thenByDefaultUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.asc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> thenByDefaultUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultUnit', Sort.desc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Species, Species, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SpeciesQueryWhereDistinct
    on QueryBuilder<Species, Species, QDistinct> {
  QueryBuilder<Species, Species, QDistinct> distinctByDefaultUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Species, Species, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension SpeciesQueryProperty
    on QueryBuilder<Species, Species, QQueryProperty> {
  QueryBuilder<Species, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Species, String?, QQueryOperations> defaultUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultUnit');
    });
  }

  QueryBuilder<Species, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFishingGearCollection on Isar {
  IsarCollection<FishingGear> get fishingGears => this.collection();
}

const FishingGearSchema = CollectionSchema(
  name: r'FishingGear',
  id: 1198886750591357300,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _fishingGearEstimateSize,
  serialize: _fishingGearSerialize,
  deserialize: _fishingGearDeserialize,
  deserializeProp: _fishingGearDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _fishingGearGetId,
  getLinks: _fishingGearGetLinks,
  attach: _fishingGearAttach,
  version: '3.1.0+1',
);

int _fishingGearEstimateSize(
  FishingGear object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _fishingGearSerialize(
  FishingGear object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

FishingGear _fishingGearDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FishingGear();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _fishingGearDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fishingGearGetId(FishingGear object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fishingGearGetLinks(FishingGear object) {
  return [];
}

void _fishingGearAttach(
    IsarCollection<dynamic> col, Id id, FishingGear object) {
  object.id = id;
}

extension FishingGearQueryWhereSort
    on QueryBuilder<FishingGear, FishingGear, QWhere> {
  QueryBuilder<FishingGear, FishingGear, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension FishingGearQueryWhere
    on QueryBuilder<FishingGear, FishingGear, QWhereClause> {
  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> idBetween(
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

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension FishingGearQueryFilter
    on QueryBuilder<FishingGear, FishingGear, QFilterCondition> {
  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension FishingGearQueryObject
    on QueryBuilder<FishingGear, FishingGear, QFilterCondition> {}

extension FishingGearQueryLinks
    on QueryBuilder<FishingGear, FishingGear, QFilterCondition> {}

extension FishingGearQuerySortBy
    on QueryBuilder<FishingGear, FishingGear, QSortBy> {
  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FishingGearQuerySortThenBy
    on QueryBuilder<FishingGear, FishingGear, QSortThenBy> {
  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FishingGear, FishingGear, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FishingGearQueryWhereDistinct
    on QueryBuilder<FishingGear, FishingGear, QDistinct> {
  QueryBuilder<FishingGear, FishingGear, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension FishingGearQueryProperty
    on QueryBuilder<FishingGear, FishingGear, QQueryProperty> {
  QueryBuilder<FishingGear, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FishingGear, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductiveUnitCollection on Isar {
  IsarCollection<ProductiveUnit> get productiveUnits => this.collection();
}

const ProductiveUnitSchema = CollectionSchema(
  name: r'ProductiveUnit',
  id: -3679104611144574755,
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
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'community': PropertySchema(
      id: 3,
      name: r'community',
      type: IsarType.string,
    ),
    r'fishermanName': PropertySchema(
      id: 4,
      name: r'fishermanName',
      type: IsarType.string,
    ),
    r'searchKey': PropertySchema(
      id: 5,
      name: r'searchKey',
      type: IsarType.string,
    )
  },
  estimateSize: _productiveUnitEstimateSize,
  serialize: _productiveUnitSerialize,
  deserialize: _productiveUnitDeserialize,
  deserializeProp: _productiveUnitDeserializeProp,
  idName: r'id',
  indexes: {
    r'searchKey': IndexSchema(
      id: -1673253136872295656,
      name: r'searchKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchKey',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _productiveUnitGetId,
  getLinks: _productiveUnitGetLinks,
  attach: _productiveUnitAttach,
  version: '3.1.0+1',
);

int _productiveUnitEstimateSize(
  ProductiveUnit object,
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
  bytesCount += 3 + object.searchKey.length * 3;
  return bytesCount;
}

void _productiveUnitSerialize(
  ProductiveUnit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.boatName);
  writer.writeString(offsets[1], object.boatType);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.community);
  writer.writeString(offsets[4], object.fishermanName);
  writer.writeString(offsets[5], object.searchKey);
}

ProductiveUnit _productiveUnitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductiveUnit();
  object.boatName = reader.readStringOrNull(offsets[0]);
  object.boatType = reader.readStringOrNull(offsets[1]);
  object.category = reader.readStringOrNull(offsets[2]);
  object.community = reader.readStringOrNull(offsets[3]);
  object.fishermanName = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.searchKey = reader.readString(offsets[5]);
  return object;
}

P _productiveUnitDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productiveUnitGetId(ProductiveUnit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _productiveUnitGetLinks(ProductiveUnit object) {
  return [];
}

void _productiveUnitAttach(
    IsarCollection<dynamic> col, Id id, ProductiveUnit object) {
  object.id = id;
}

extension ProductiveUnitQueryWhereSort
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QWhere> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhere> anySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'searchKey'),
      );
    });
  }
}

extension ProductiveUnitQueryWhere
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QWhereClause> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause> idBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyEqualTo(String searchKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey',
        value: [searchKey],
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyNotEqualTo(String searchKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyGreaterThan(
    String searchKey, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [searchKey],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyLessThan(
    String searchKey, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [],
        upper: [searchKey],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyBetween(
    String lowerSearchKey,
    String upperSearchKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [lowerSearchKey],
        includeLower: includeLower,
        upper: [upperSearchKey],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyStartsWith(String SearchKeyPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey',
        lower: [SearchKeyPrefix],
        upper: ['$SearchKeyPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey',
        value: [''],
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterWhereClause>
      searchKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchKey',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchKey',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchKey',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchKey',
              upper: [''],
            ));
      }
    });
  }
}

extension ProductiveUnitQueryFilter
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QFilterCondition> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boatName',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boatName',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameEqualTo(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameGreaterThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameStartsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameEndsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boatName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boatName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boatName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boatType',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boatType',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeEqualTo(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeGreaterThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeStartsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeEndsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boatType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boatType',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      boatTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boatType',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryEqualTo(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryGreaterThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryStartsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryEndsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'community',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'community',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityEqualTo(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityGreaterThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityStartsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityEndsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'community',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'community',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'community',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      communityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'community',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fishermanName',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fishermanName',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameEqualTo(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameStartsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameEndsWith(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fishermanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fishermanName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fishermanName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      fishermanNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fishermanName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterFilterCondition>
      searchKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchKey',
        value: '',
      ));
    });
  }
}

extension ProductiveUnitQueryObject
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QFilterCondition> {}

extension ProductiveUnitQueryLinks
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QFilterCondition> {}

extension ProductiveUnitQuerySortBy
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QSortBy> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> sortByBoatName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByBoatNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> sortByBoatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByBoatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> sortByCommunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByCommunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByFishermanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortByFishermanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> sortBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      sortBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }
}

extension ProductiveUnitQuerySortThenBy
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QSortThenBy> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenByBoatName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByBoatNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatName', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenByBoatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByBoatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boatType', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenByCommunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByCommunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'community', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByFishermanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenByFishermanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fishermanName', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy> thenBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QAfterSortBy>
      thenBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }
}

extension ProductiveUnitQueryWhereDistinct
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> {
  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> distinctByBoatName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boatName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> distinctByBoatType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boatType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> distinctByCommunity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'community', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct>
      distinctByFishermanName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fishermanName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductiveUnit, ProductiveUnit, QDistinct> distinctBySearchKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchKey', caseSensitive: caseSensitive);
    });
  }
}

extension ProductiveUnitQueryProperty
    on QueryBuilder<ProductiveUnit, ProductiveUnit, QQueryProperty> {
  QueryBuilder<ProductiveUnit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProductiveUnit, String?, QQueryOperations> boatNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boatName');
    });
  }

  QueryBuilder<ProductiveUnit, String?, QQueryOperations> boatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boatType');
    });
  }

  QueryBuilder<ProductiveUnit, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<ProductiveUnit, String?, QQueryOperations> communityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'community');
    });
  }

  QueryBuilder<ProductiveUnit, String?, QQueryOperations>
      fishermanNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fishermanName');
    });
  }

  QueryBuilder<ProductiveUnit, String, QQueryOperations> searchKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchKey');
    });
  }
}
