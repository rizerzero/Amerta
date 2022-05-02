import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/transaction/recent_transaction_model.dart';
import '../model/transaction/summary_transaction_model.dart';
import '../model/transaction/transaction_form_parameter.dart';
import '../service/local/transaction_local_service.dart';

class TransactionRepository {
  const TransactionRepository({
    required this.transactionLocalService,
  });

  final TransactionLocalService transactionLocalService;

  Future<Either<Failure, SummaryTransactionModel>> getSummaryTransaction(String? peopleId) async {
    try {
      final result = await transactionLocalService.getSummaryTransaction(peopleId);
      return Right(result);
    } on SqliteException catch (exception, _) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<RecentTransactionModel>>> getRecentTransaction({
    required TransactionType type,
    String? peopleId,
    int? limit,
  }) async {
    try {
      final result = await transactionLocalService.getRecentTransaction(
        type: type,
        limit: limit,
        peopleId: peopleId,
      );
      return Right(result);
    } on SqliteException catch (exception, _) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> insertOrUpdateTransaction(TransactionFormParameter form) async {
    try {
      final result = await transactionLocalService.insertOrUpdateTransaction(form);
      return Right(result);
    } on SqliteException catch (exception, _) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteTransaction(String id) async {
    try {
      final result = await transactionLocalService.deleteTransaction(id);
      return Right(result);
    } on SqliteException catch (exception, _) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
