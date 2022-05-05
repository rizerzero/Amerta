part of 'people_notifier.dart';

class PeopleState extends Equatable {
  const PeopleState({
    this.item = const AsyncData(null),
  });
  final AsyncValue<PeopleModel?> item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'PeopleState(item: $item)';

  PeopleState copyWith({
    AsyncValue<PeopleModel?>? item,
  }) {
    return PeopleState(
      item: item ?? this.item,
    );
  }
}
