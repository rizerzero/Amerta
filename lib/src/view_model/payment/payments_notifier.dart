import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/payment/payment_model.dart';
import 'payment_action_notifier.dart';

final getPayments = FutureProvider.autoDispose.family<Map<DateTime, List<PaymentModel>>, String>(
  (ref, transactionId) async {
    /// Every [add / update / delete] payment, refresh this provider
    ref.listen<PaymentActionState>(paymentActionNotifier, (_, state) {
      state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
      state.delete.whenData((_) => ref.invalidateSelf());
    });

    final result = await ref.watch(paymentRepository).getPayments(transactionId);

    return result.getOrElse(() => {});
  },
);
