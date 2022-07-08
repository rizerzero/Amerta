import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/payment/payment_model.dart';

final getPaymentById = FutureProvider.autoDispose.family<PaymentModel?, String?>((ref, id) async {
  final repository = ref.watch(paymentRepository);
  final result = await repository.getById(id);
  return result.fold((failure) => throw failure.message, (payment) => payment);
});
