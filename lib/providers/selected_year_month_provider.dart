import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_year_month_provider.g.dart';

@riverpod
class SelectedYearMonth extends _$SelectedYearMonth {
  @override
  DateTime build() => DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
      );

  void setSelectedYearMonth(DateTime selectedYearMonth) {
    state = selectedYearMonth;
  }
}
