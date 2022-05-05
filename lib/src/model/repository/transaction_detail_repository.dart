import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/transaction_detail/form_transaction_detail_parameter.dart';
import '../model/transaction_detail/transaction_detail_insertorupdate_response.dart';
import '../model/transaction_detail/transaction_detail_model.dart';
import '../model/transaction_detail/transaction_detail_summary_model.dart';
import '../service/local/transaction_detail_local_service.dart';

class TransactionDetailRepository {
  const TransactionDetailRepository({
    required this.transactionDetailLocalService,
  });
  final TransactionDetailLocalService transactionDetailLocalService;

  Future<Either<Failure, TransactionDetailModel?>> getById(String? id) async {
    try {
      final result = await transactionDetailLocalService.getById(id);
      return Right(result);
    } on SqliteException catch (exception, _) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, TransactionDetailInsertOrUpdateResponse>> insertOrUpdateTransactionDetail(
    FormTransactionDetailParameter form,
  ) async {
    try {
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
      final result = await transactionDetailLocalService.getTransactionsDetail(transactionId);
      return Right(result);
    } on SqliteException catch (exception, _) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }
}
