import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthly_budget_provider.g.dart';

@riverpod
class MonthlyBudget extends _$MonthlyBudget {
  @override
  int? build() => null;

  void setMonthlyBudget(int? monthlyBudget) {
    state = monthlyBudget;
  }
}
