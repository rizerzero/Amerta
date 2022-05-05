part of 'peoples_summary_notifier.dart';

class PeoplesSummaryState extends Equatable {
  final AsyncValue<List<PeopleSummaryModel>> items;
  const PeoplesSummaryState({
    this.items = const AsyncData([]),
  });

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'PeoplesSummaryState(items: $items)';

  PeoplesSummaryState copyWith({
    AsyncValue<List<PeopleSummaryModel>>? items,
  }) {
    return PeoplesSummaryState(
      items: items ?? this.items,
    );
  }
}
