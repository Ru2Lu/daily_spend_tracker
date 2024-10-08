import 'package:isar/isar.dart';

part 'budget.g.dart';

@collection
class Budget {
  Budget({
    this.id = Isar.autoIncrement,
    required this.amount,
    required this.date,
  });

  final Id id;

  int? amount;

  DateTime? date;
}
