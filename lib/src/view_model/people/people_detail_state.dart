part of 'people_detail_notifier.dart';

class PeopleDetailState extends Equatable {
  const PeopleDetailState({
    this.item = const AsyncData(null),
  });

  final AsyncValue<PeopleModel?> item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'PeopleDetailState(item: $item)';

  PeopleDetailState copyWith({
    AsyncValue<PeopleModel?>? item,
  }) {
    return PeopleDetailState(
      item: item ?? this.item,
    );
  }
}
