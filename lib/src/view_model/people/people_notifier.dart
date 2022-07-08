import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/people/people_model.dart';

final getPeopleById =
    FutureProvider.autoDispose.family<PeopleModel?, String?>((ref, peopleId) async {
  final repository = ref.watch(peopleRepository);
  final result = await repository.getById(peopleId);
  return result.fold((failure) => throw failure.message, (people) => people);
});
