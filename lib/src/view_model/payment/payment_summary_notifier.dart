import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/payment/payment_summary_model.dart';
import '../../model/model/payment/payment_summary_parameter.dart';
import 'payment_action_notifier.dart';

final getPaymentSummary = FutureProvider.autoDispose
    .family<PaymentSummaryModel?, PaymentSummaryParameter>((ref, param) async {
  /// Setiap ada aksi dari [paymentActionNotifier]
  /// Refresh provider ini
  ref.listen<PaymentActionState>(paymentActionNotifier, (previous, next) {
    next.insertOrUpdate.whenData((value) => ref.invalidateSelf());
    next.delete.whenData((value) => ref.invalidateSelf());
  });
  final result = await ref.watch(paymentRepository).getPaymentSummary(
        peopleId: param.peopleId,
        transactionId: param.transactionId,
      );

  return result.getOrElse(() => null);
});
