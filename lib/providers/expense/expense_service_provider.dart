import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../services/expense_service.dart';
import '../isar_provider.dart';

part 'expense_service_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ExpenseService> expenseService(
  ExpenseServiceRef ref,
) async {
  final isar = await ref.watch(isarProvider.future);
  return ExpenseService(isar);
}
