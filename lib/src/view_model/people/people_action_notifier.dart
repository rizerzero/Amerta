import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/people/form_people_parameter.dart';
import '../../model/model/people/people_insertorupdate_response.dart';
import '../../model/repository/people_repository.dart';

part 'people_action_state.dart';

class PeopleActionNotifier extends StateNotifier<PeopleActionState> {
  PeopleActionNotifier(
    this.repository,
  ) : super(const PeopleActionState());

  final PeopleRepository repository;

  Future<PeopleActionState> delete(String peopleId) async {
    state = state.copyWith(deleteAsync: const AsyncLoading());

    final result = await repository.delete(peopleId);
    return result.fold(
      (failure) => state = state.copyWith(deleteAsync: AsyncError(failure.message)),
      (val) => state = state.copyWith(deleteAsync: AsyncData(val)),
    );
  }

  Future<PeopleActionState> insertOrUpdate(FormPeopleParameter form) async {
    state = state.copyWith(insertOrUpdateAsync: const AsyncLoading());
    final result = await repository.insertOrUpdate(form);
    return result.fold(
      (failure) => state = state.copyWith(insertOrUpdateAsync: AsyncError(failure.message)),
      (val) => state = state.copyWith(insertOrUpdateAsync: AsyncData(val)),
    );
  }
}
