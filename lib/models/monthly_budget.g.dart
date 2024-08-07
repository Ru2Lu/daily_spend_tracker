// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_budget.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlyBudgetCollection on Isar {
  IsarCollection<MonthlyBudget> get monthlyBudgets => this.collection();
}

const MonthlyBudgetSchema = CollectionSchema(
  name: r'MonthlyBudget',
  id: -5743211326019024722,
  properties: {
    r'budget': PropertySchema(
      id: 0,
      name: r'budget',
      type: IsarType.long,
    )
  },
  estimateSize: _monthlyBudgetEstimateSize,
  serialize: _monthlyBudgetSerialize,
  deserialize: _monthlyBudgetDeserialize,
  deserializeProp: _monthlyBudgetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _monthlyBudgetGetId,
  getLinks: _monthlyBudgetGetLinks,
  attach: _monthlyBudgetAttach,
  version: '3.1.0+1',
);

int _monthlyBudgetEstimateSize(
  MonthlyBudget object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _monthlyBudgetSerialize(
  MonthlyBudget object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.budget);
}

MonthlyBudget _monthlyBudgetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlyBudget(
    budget: reader.readLongOrNull(offsets[0]),
    id: id,
  );
  return object;
}

P _monthlyBudgetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monthlyBudgetGetId(MonthlyBudget object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlyBudgetGetLinks(MonthlyBudget object) {
  return [];
}

void _monthlyBudgetAttach(
    IsarCollection<dynamic> col, Id id, MonthlyBudget object) {}

extension MonthlyBudgetQueryWhereSort
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QWhere> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonthlyBudgetQueryWhere
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QWhereClause> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterWhereClause> idBetween(
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
}

extension MonthlyBudgetQueryFilter
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QFilterCondition> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'budget',
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'budget',
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
      budgetBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'budget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition>
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

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterFilterCondition> idBetween(
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
}

extension MonthlyBudgetQueryObject
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QFilterCondition> {}

extension MonthlyBudgetQueryLinks
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QFilterCondition> {}

extension MonthlyBudgetQuerySortBy
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QSortBy> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> sortByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.asc);
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> sortByBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.desc);
    });
  }
}

extension MonthlyBudgetQuerySortThenBy
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QSortThenBy> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> thenByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.asc);
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> thenByBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.desc);
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlyBudget, MonthlyBudget, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension MonthlyBudgetQueryWhereDistinct
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QDistinct> {
  QueryBuilder<MonthlyBudget, MonthlyBudget, QDistinct> distinctByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'budget');
    });
  }
}

extension MonthlyBudgetQueryProperty
    on QueryBuilder<MonthlyBudget, MonthlyBudget, QQueryProperty> {
  QueryBuilder<MonthlyBudget, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlyBudget, int?, QQueryOperations> budgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'budget');
    });
  }
}
