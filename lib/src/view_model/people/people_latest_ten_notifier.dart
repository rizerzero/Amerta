import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import 'people_action_notifier.dart';

final getLatestTenPeople = FutureProvider.autoDispose((ref) async {
  /// Every [add / update / delete] people, refresh this provider
  ref.listen<PeopleActionState>(peopleActionNotifier, (_, state) {
    state.deleteAsync.whenData((_) => ref.invalidateSelf());
    state.insertOrUpdateAsync.whenData((_) => ref.invalidateSelf());
  });

  final result = await ref.watch(peopleRepository).getLatestTenPeople();
  return result.getOrElse(() => []);
});
