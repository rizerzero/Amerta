import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/transaction/form_transaction_parameter.dart';
import '../model/transaction/print_transaction_parameter.dart';
import '../model/transaction/recent_transaction_model.dart';
import '../model/transaction/summary_transaction_model.dart';
import '../model/transaction/transaction_insertorupdate_response.dart';
import '../model/transaction/transaction_model.dart';
import '../service/local/transaction_local_service.dart';

class TransactionRepository {
  const TransactionRepository({
    required this.transactionLocalService,
  });

  final TransactionLocalService transactionLocalService;

  Future<Either<Failure, List<SummaryTransactionModel>>> getSummaryTransaction(
      String? peopleId) async {
    try {
      final result = await transactionLocalService.getSummaryTransaction(peopleId);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<RecentTransactionModel>>> getTransactions({
    required TransactionType type,
    String? peopleId,
    PaymentStatus? paymentStatus,
    int? limit,
  }) async {
    try {
      final result = await transactionLocalService.getTransactions(
        type: type,
        limit: limit,
        peopleId: peopleId,
      );
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, TransactionModel?>> getById(String? id) async {
    try {
      final result = await transactionLocalService.getById(id);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, TransactionInsertOrUpdateResponse>> insertOrUpdateTransaction(
      FormTransactionParameter form) async {
    try {
      final result = await transactionLocalService.insertOrUpdateTransaction(form);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteTransaction(String id) async {
    try {
      final result = await transactionLocalService.deleteTransaction(id);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Uint8List>> printTransaction(PrintTransactionParameter parameter) async {
    try {
      final result = await transactionLocalService.printTransaction(parameter);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
