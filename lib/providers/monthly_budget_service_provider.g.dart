// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_budget_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlyBudgetServiceHash() =>
    r'f24960a5dc49ac3897fc4bda1c247ad5b8d6bba8';

/// See also [monthlyBudgetService].
@ProviderFor(monthlyBudgetService)
final monthlyBudgetServiceProvider =
    FutureProvider<MonthlyBudgetService>.internal(
  monthlyBudgetService,
  name: r'monthlyBudgetServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$monthlyBudgetServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MonthlyBudgetServiceRef = FutureProviderRef<MonthlyBudgetService>;
String _$monthlyBudgetHash() => r'c747e1afc8a1bdf38fe71fa188343821f55cfef7';

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

/// See also [monthlyBudget].
@ProviderFor(monthlyBudget)
const monthlyBudgetProvider = MonthlyBudgetFamily();

/// See also [monthlyBudget].
class MonthlyBudgetFamily extends Family<AsyncValue<MonthlyBudget?>> {
  /// See also [monthlyBudget].
  const MonthlyBudgetFamily();

  /// See also [monthlyBudget].
  MonthlyBudgetProvider call(
    int year,
    int month,
  ) {
    return MonthlyBudgetProvider(
      year,
      month,
    );
  }

  @override
  MonthlyBudgetProvider getProviderOverride(
    covariant MonthlyBudgetProvider provider,
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
  String? get name => r'monthlyBudgetProvider';
}

/// See also [monthlyBudget].
class MonthlyBudgetProvider extends AutoDisposeStreamProvider<MonthlyBudget?> {
  /// See also [monthlyBudget].
  MonthlyBudgetProvider(
    int year,
    int month,
  ) : this._internal(
          (ref) => monthlyBudget(
            ref as MonthlyBudgetRef,
            year,
            month,
          ),
          from: monthlyBudgetProvider,
          name: r'monthlyBudgetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlyBudgetHash,
          dependencies: MonthlyBudgetFamily._dependencies,
          allTransitiveDependencies:
              MonthlyBudgetFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  MonthlyBudgetProvider._internal(
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
    Stream<MonthlyBudget?> Function(MonthlyBudgetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyBudgetProvider._internal(
        (ref) => create(ref as MonthlyBudgetRef),
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
  AutoDisposeStreamProviderElement<MonthlyBudget?> createElement() {
    return _MonthlyBudgetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyBudgetProvider &&
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

mixin MonthlyBudgetRef on AutoDisposeStreamProviderRef<MonthlyBudget?> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlyBudgetProviderElement
    extends AutoDisposeStreamProviderElement<MonthlyBudget?>
    with MonthlyBudgetRef {
  _MonthlyBudgetProviderElement(super.provider);

  @override
  int get year => (origin as MonthlyBudgetProvider).year;
  @override
  int get month => (origin as MonthlyBudgetProvider).month;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
