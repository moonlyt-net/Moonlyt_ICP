import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/wallet/transaction_record_model.dart';

class TransactionRecordsNotifier
    extends StateNotifier<List<TransactionRecordModel>> {
  TransactionRecordsNotifier() : super([]);

  void addTransactionRecord(String date, double amount, String type) {
    state = [
      ...state,
      TransactionRecordModel(date: date, amount: amount, type: type),
    ];
  }
}

final transactionRecordsProvider = StateNotifierProvider<
    TransactionRecordsNotifier, List<TransactionRecordModel>>((ref) {
  return TransactionRecordsNotifier();
});
