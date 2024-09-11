// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$budgetServiceHash() => r'fb617021e135810c856be6fa21f1f166d35bb338';

/// See also [budgetService].
@ProviderFor(budgetService)
final budgetServiceProvider = FutureProvider<BudgetService>.internal(
  budgetService,
  name: r'budgetServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$budgetServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BudgetServiceRef = FutureProviderRef<BudgetService>;
String _$budgetHash() => r'a35bb24367d0a4216b350ef29fd191e2faefb1a9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [budget].
@ProviderFor(budget)
const budgetProvider = BudgetFamily();

/// See also [budget].
class BudgetFamily extends Family<AsyncValue<Budget?>> {
  /// See also [budget].
  const BudgetFamily();

  /// See also [budget].
  BudgetProvider call(
    int year,
    int month,
  ) {
    return BudgetProvider(
      year,
      month,
    );
  }

  @override
  BudgetProvider getProviderOverride(
    covariant BudgetProvider provider,
  ) {
    return call(
      provider.year,
      provider.month,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'budgetProvider';
}

/// See also [budget].
class BudgetProvider extends AutoDisposeStreamProvider<Budget?> {
  /// See also [budget].
  BudgetProvider(
    int year,
    int month,
  ) : this._internal(
          (ref) => budget(
            ref as BudgetRef,
            year,
            month,
          ),
          from: budgetProvider,
          name: r'budgetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$budgetHash,
          dependencies: BudgetFamily._dependencies,
          allTransitiveDependencies: BudgetFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  BudgetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    Stream<Budget?> Function(BudgetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BudgetProvider._internal(
        (ref) => create(ref as BudgetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Budget?> createElement() {
    return _BudgetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BudgetProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BudgetRef on AutoDisposeStreamProviderRef<Budget?> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _BudgetProviderElement extends AutoDisposeStreamProviderElement<Budget?>
    with BudgetRef {
  _BudgetProviderElement(super.provider);

  @override
  int get year => (origin as BudgetProvider).year;
  @override
  int get month => (origin as BudgetProvider).month;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
