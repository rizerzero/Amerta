import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/people/people_summary_model.dart';
import '../../model/repository/people_repository.dart';

part 'peoples_summary_state.dart';

class PeoplesSummaryNotifier extends StateNotifier<PeoplesSummaryState> {
  PeoplesSummaryNotifier({required this.repository}) : super(const PeoplesSummaryState()) {
    getPeopleSummary();
  }

  final PeopleRepository repository;

  Future<PeoplesSummaryState> getPeopleSummary() async {
    state = state.copyWith(items: const AsyncLoading());
    final result = await repository.getPeopleSummary();
    return result.fold(
      (l) => state = state.copyWith(items: AsyncError(l.message)),
      (r) => state = state.copyWith(items: AsyncData(r)),
    );
  }
}

final queryPeoplesSummary = StateProvider.autoDispose<String?>((ref) => null);

final filteredPeoplesSummary = Provider.autoDispose<List<PeopleSummaryModel>>((ref) {
  final query = ref.watch(queryPeoplesSummary);
  final items = ref.watch(peoplesSummaryNotifier).items.value ?? [];
  if (query == null || query.isEmpty) return items;
  return items
      .where((element) => element.people.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final totalPeoplesSummary = Provider.autoDispose<int>((ref) {
  final items = ref.watch(filteredPeoplesSummary);
  return items.length;
});
