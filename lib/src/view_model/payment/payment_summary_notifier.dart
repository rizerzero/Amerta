import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/payment/payment_summary_model.dart';
import '../../model/model/payment/payment_summary_parameter.dart';
import 'payment_action_notifier.dart';

final getPaymentSummary = FutureProvider.autoDispose
    .family<PaymentSummaryModel?, PaymentSummaryParameter>((ref, param) async {
  /// Every [add / update / delete] transaction detail, refresh this provider
  ref.listen<PaymentActionState>(paymentActionNotifier, (_, state) {
    state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
    state.delete.whenData((_) => ref.invalidateSelf());
  });

  final result = await ref.watch(paymentRepository).getPaymentSummary(
        peopleId: param.peopleId,
        transactionId: param.transactionId,
      );

  return result.getOrElse(() => null);
});
