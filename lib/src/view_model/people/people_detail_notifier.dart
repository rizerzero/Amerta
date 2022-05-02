import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/people/people_model.dart';
import '../../model/repository/people_repository.dart';

part 'people_detail_state.dart';

class PeopleDetailNotifier extends StateNotifier<PeopleDetailState> {
  PeopleDetailNotifier({required this.repository}) : super(const PeopleDetailState());

  final PeopleRepository repository;

  Future<PeopleDetailState> getById(String peopleId) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.getById(peopleId);
    return result.fold(
      (failure) => state = state.copyWith(item: AsyncError(failure.message)),
      (item) => state = state.copyWith(item: AsyncData(item)),
    );
  }
}
