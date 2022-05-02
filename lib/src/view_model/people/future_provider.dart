import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';

final getLatestTenPeople = FutureProvider.autoDispose((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final result = await ref.watch(peopleRepository).getLatestTenPeople();
  return result.getOrElse(() => []);
});

final getPeoples = FutureProvider.autoDispose((ref) async {
  final result = await ref.watch(peopleRepository).getPeoples();
  return result.getOrElse(() => []);
});
