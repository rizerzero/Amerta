import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/people/people_model.dart';
import '../../model/repository/people_repository.dart';

part 'people_state.dart';

class PeopleNotifier extends StateNotifier<PeopleState> {
  PeopleNotifier({
    required this.repository,
    required this.peopleId,
  }) : super(const PeopleState()) {
    getById(peopleId);
  }

  final PeopleRepository repository;
  final String? peopleId;

  Future<PeopleState> getById(String? peopleId) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.getById(peopleId);
    return result.fold(
      (failure) => state = state.copyWith(item: AsyncError(failure.message)),
      (item) => state = state.copyWith(item: AsyncData(item)),
    );
  }
}
