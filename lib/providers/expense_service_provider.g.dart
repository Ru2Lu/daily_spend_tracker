// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseServiceHash() => r'e1764fc10fea7640268d3fa15995d8657ee09450';

/// See also [expenseService].
@ProviderFor(expenseService)
final expenseServiceProvider = FutureProvider<ExpenseService>.internal(
  expenseService,
  name: r'expenseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpenseServiceRef = FutureProviderRef<ExpenseService>;
String _$expensesHash() => r'36c636032ad1f1af864004f79a2fdb57f67127c9';

/// See also [expenses].
@ProviderFor(expenses)
final expensesProvider = AutoDisposeStreamProvider<List<Expense>?>.internal(
  expenses,
  name: r'expensesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$expensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpensesRef = AutoDisposeStreamProviderRef<List<Expense>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
