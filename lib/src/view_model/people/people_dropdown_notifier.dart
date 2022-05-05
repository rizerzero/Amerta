import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import 'people_action_notifier.dart';

final getDropdownPeoples = FutureProvider.autoDispose((ref) async {
  /// Jika ada [penambahan / update / delete] dari people, refresh provider ini
  ref.listen<PeopleActionState>(peopleActionNotifier, (_, state) {
    state.deleteAsync.whenOrNull(data: (_) => ref.invalidateSelf());
    state.insertOrUpdateAsync.whenOrNull(data: (_) => ref.invalidateSelf());
  });

  final result = await ref.watch(peopleRepository).get();
  return result.getOrElse(() => []);
});
