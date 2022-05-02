import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/transaction_detail/transaction_detail_form_parameter.dart';
import '../model/transaction_detail/transaction_detail_model.dart';
import '../model/transaction_detail/transaction_detail_summary_model.dart';
import '../service/local/transaction_detail_local_service.dart';

class TransactionDetailRepository {
  const TransactionDetailRepository({
    required this.transactionDetailLocalService,
  });
  final TransactionDetailLocalService transactionDetailLocalService;

  Future<Either<Failure, int>> insertOrUpdateTransactionDetail(
    TransactionDetailFormParameter form,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await transactionDetailLocalService.insertOrUpdateTransactionDetail(form);
      return Right(result);
    } on SqliteException catch (exception, _) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteTransactionDetail(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await transactionDetailLocalService.deleteTransactionDetail(id);
      return Right(result);
    } on SqliteException catch (exception, _) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, TransactionDetailSummaryModel?>> getTransactionDetailSummary({
    required String peopleId,
    required String transactionId,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await transactionDetailLocalService.getTransactionDetailSummary(
        peopleId: peopleId,
        transactionId: transactionId,
      );

      return Right(result);
    } on SqliteException catch (exception, _) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<DateTime, List<TransactionDetailModel>>>> getTransactionsDetail(
    String transactionId,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await transactionDetailLocalService.getTransactionsDetail(transactionId);
      return Right(result);
    } on SqliteException catch (exception, _) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }
}
