import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/people/people_summary_model.dart';

final queryPeoplesSummary = StateProvider.autoDispose<String?>((ref) => null);

final filteredPeoplesSummary = Provider.autoDispose<List<PeopleSummaryModel>>((ref) {
  final query = ref.watch(queryPeoplesSummary);
  final items = ref.watch(getPeoplesSummaryTransaction).value ?? [];
  if (query == null || query.isEmpty) return items;
  return items
      .where((element) => element.people.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final totalPeoplesSummary = Provider.autoDispose<int>((ref) {
  final items = ref.watch(filteredPeoplesSummary);
  return items.length;
});

final getPeoplesSummaryTransaction = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(peopleRepository);
  final result = await repository.getPeoplesSummary();
  return result.fold((failure) => throw failure.message, (summaries) => summaries);
});
