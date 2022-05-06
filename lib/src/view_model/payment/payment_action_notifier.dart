import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/payment/form_payment_parameter.dart';
import '../../model/model/payment/payment_insertorupdate_response.dart';
import '../../model/repository/payment_repository.dart';

part 'payment_action_state.dart';

class PaymentActionNotifier extends StateNotifier<PaymentActionState> {
  PaymentActionNotifier({
    required this.repository,
  }) : super(const PaymentActionState());

  final PaymentRepository repository;

  Future<PaymentActionState> insertOrUpdatePayment(
    FormPaymentParameter form,
  ) async {
    state = state.copyWith(insertOrUpdate: const AsyncLoading());
    final result = await repository.insertOrUpdatePayment(form);
    return result.fold(
      (failure) => state = state.copyWith(insertOrUpdate: AsyncError(failure.message)),
      (val) => state = state.copyWith(insertOrUpdate: const AsyncData(null)),
    );
  }

  Future<PaymentActionState> deletePayment(String id) async {
    state = state.copyWith(delete: const AsyncLoading());
    final result = await repository.deletePayment(id);
    return result.fold(
      (failure) => state = state.copyWith(delete: AsyncError(failure.message)),
      (val) => state = state.copyWith(delete: const AsyncData(null)),
    );
  }
}
