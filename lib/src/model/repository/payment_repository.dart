import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/payment/form_payment_parameter.dart';
import '../model/payment/payment_insertorupdate_response.dart';
import '../model/payment/payment_model.dart';
import '../model/payment/payment_summary_model.dart';
import '../model/payment/payments_parameter.dart';
import '../service/local/payment_local_service.dart';

class PaymentRepository {
  const PaymentRepository({
    required this.localService,
  });
  final PaymentLocalService localService;

  Future<Either<Failure, PaymentModel?>> getById(String? id) async {
    try {
      final result = await localService.getById(id);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, PaymentInsertOrUpdateResponse>> insertOrUpdatePayment(
    FormPaymentParameter form,
  ) async {
    try {
      final result = await localService.insertOrUpdatePayment(form);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deletePayment(String id) async {
    try {
      final result = await localService.deletePayment(id);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, PaymentSummaryModel?>> getPaymentSummary({
    required String peopleId,
    required String transactionId,
  }) async {
    try {
      final result = await localService.getPaymentSummary(
        peopleId: peopleId,
        transactionId: transactionId,
      );

      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<DateTime, List<PaymentModel>>>> getPayments(
    PaymentsParameter param,
  ) async {
    try {
      final result = await localService.getPayments(param);
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }
}
