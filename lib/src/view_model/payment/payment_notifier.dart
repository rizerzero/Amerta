import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/payment/payment_model.dart';
import '../../model/repository/payment_repository.dart';

part 'payment_state.dart';

class PaymentNotifier extends StateNotifier<PaymentState> {
  PaymentNotifier({
    required this.repository,
    required this.id,
  }) : super(const PaymentState()) {
    getById(id);
  }

  final PaymentRepository repository;
  final String? id;

  Future<PaymentState> getById(String? id) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.getById(id);
    return result.fold(
      (l) => state = state.copyWith(item: AsyncError(l.message)),
      (r) => state = state.copyWith(item: AsyncData(r)),
    );
  }
}
