import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';
import '../../model/people/people_createorupdate_response.dart';
import '../../model/people/people_model.dart';

class PeopleLocalService {
  const PeopleLocalService({
    required this.peopleBox,
  });
  final Box<PeopleModel> peopleBox;

  Future<List<PeopleModel>> get() async {
    final result = peopleBox.values.toList();
    return result;
  }

  Future<PeopleModel> getById(String peopleId) async {
    final result = peopleBox.get(peopleId) ?? const PeopleModel();
    return result;
  }

  Future<PeopleCreateOrUpdateResponse> createOrUpdate(PeopleModel people) async {
    PeopleCreateOrUpdateResponse response = const PeopleCreateOrUpdateResponse();

    final item = peopleBox.get(people.id);

    /// Update
    if (item != null) {
      people = people.copyWith(updatedAt: DateTime.now());
      response = response.copyWith(
        isNewPeople: false,
        message: "Berhasil mengupdate ${people.name}",
      );

      /// Tambah
    } else {
      people = people.copyWith(id: const Uuid().v4(), createdAt: DateTime.now());
      response = response.copyWith(
        isNewPeople: true,
        message: "Berhasil menambahkan ${people.name}",
      );
    }

    await peopleBox.put(people.id, people);

    return response;
  }

  Future<String> removeById(PeopleModel people) async {
    await peopleBox.delete(people.id);
    return "Berhasil menghapus ${people.name}";
  }

  Future<String> removeAll() async {
    await peopleBox.deleteAll(peopleBox.keys);
    return "Berhasil menghapus semua data orang";
  }
}

abstract class PeopleRepository {
  Future<Either<Failure, List<PeopleModel>>> get();
  Future<Either<Failure, PeopleModel>> getById(String peopleId);
  Future<Either<Failure, PeopleCreateOrUpdateResponse>> createOrUpdate(PeopleModel people);
  Future<Either<Failure, String>> removeById(PeopleModel people);
}

class PeopleRepositoryImplement implements PeopleRepository {
  const PeopleRepositoryImplement({
    required this.peopleLocalService,
  });
  final PeopleLocalService peopleLocalService;
  @override
  Future<Either<Failure, PeopleCreateOrUpdateResponse>> createOrUpdate(PeopleModel people) async {
    try {
      final result = await peopleLocalService.createOrUpdate(people);
      return Right(result);
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeopleModel>>> get() async {
    try {
      final result = await peopleLocalService.get();
      return Right(result);
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeById(PeopleModel people) async {
    try {
      final result = await peopleLocalService.removeById(people);
      return Right(result);
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PeopleModel>> getById(String peopleId) async {
    try {
      final result = await peopleLocalService.getById(peopleId);
      return Right(result);
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}

class PeoplesNotifier extends StateNotifier<PeopleState> {
  PeoplesNotifier({required this.peopleRepository}) : super(const PeopleState());

  final PeopleRepository peopleRepository;

  Future<PeopleState> get() async {
    state = state.copyWith(get: const AsyncLoading());
    final result = await peopleRepository.get();
    return result.fold(
      (failure) => state = state.copyWith(get: AsyncError(failure.message)),
      (items) => state = state.copyWith(get: const AsyncData(null), items: items),
    );
  }

  Future<PeopleState> createOrUpdate(PeopleModel people) async {
    state = state.copyWith(createOrUpdate: const AsyncLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await peopleRepository.createOrUpdate(people);
    return result.fold(
      (failure) => state = state.copyWith(createOrUpdate: AsyncError(failure.message)),
      (response) {
        var items = <PeopleModel>[];
        if (response.isNewPeople) {
          items = [...state.items, response.people];
        } else {
          items = [
            for (final people in state.items)
              if (people.id == response.people.id) response.people else people
          ];
        }

        return state = state.copyWith(
          createOrUpdate: const AsyncData(null),
          items: items,
        );
      },
    );
  }

  Future<PeopleState> removeById(PeopleModel people) async {
    state = state.copyWith(removeById: const AsyncLoading());
    final result = await peopleRepository.removeById(people);
    return result.fold(
      (failure) => state = state.copyWith(removeById: AsyncError(failure.message)),
      (message) => state = state.copyWith(
        removeById: const AsyncData(null),
        items: [
          ...state.items.where((element) => element.id != people.id).toList(),
        ],
      ),
    );
  }
}

class PeopleState extends Equatable {
  const PeopleState({
    this.items = const [],
    this.get = const AsyncData(null),
    this.createOrUpdate = const AsyncData(null),
    this.removeById = const AsyncData(null),
  });

  final List<PeopleModel> items;

  /// [AsyncValue] usefull for handling [error, loading, data]
  /// My preference is each action must be made its own [asyncValue]
  final AsyncValue<void> get;
  final AsyncValue<void> createOrUpdate;
  final AsyncValue<void> removeById;

  @override
  List<Object> get props => [items, get, createOrUpdate, removeById];

  @override
  String toString() {
    return 'PeopleState(items: $items, get: $get, createOrUpdate: $createOrUpdate, removeById: $removeById)';
  }

  PeopleState copyWith({
    List<PeopleModel>? items,
    AsyncValue<void>? get,
    AsyncValue<void>? createOrUpdate,
    AsyncValue<void>? removeById,
  }) {
    return PeopleState(
      items: items ?? this.items,
      get: get ?? this.get,
      createOrUpdate: createOrUpdate ?? this.createOrUpdate,
      removeById: removeById ?? this.removeById,
    );
  }
}

class PeopleDetailNotifier extends StateNotifier<PeopleDetailState> {
  PeopleDetailNotifier({required this.peopleRepository}) : super(const PeopleDetailState());
  final PeopleRepository peopleRepository;

  Future<PeopleDetailState> getById(String peopleId) async {
    state = state.copyWith(getById: const AsyncLoading());
    final result = await peopleRepository.getById(peopleId);
    return result.fold(
      (failure) => state = state.copyWith(getById: AsyncError(failure.message)),
      (item) => state = state.copyWith(
        getById: const AsyncData(null),
        people: item,
      ),
    );
  }
}

class PeopleDetailState extends Equatable {
  const PeopleDetailState({
    this.people = const PeopleModel(),
    this.getById = const AsyncData(null),
  });

  final PeopleModel people;
  final AsyncValue<void> getById;

  @override
  List<Object?> get props => [people, getById];

  @override
  String toString() => 'PeopleDetailState(people: $people, getById: $getById)';

  PeopleDetailState copyWith({
    PeopleModel? people,
    AsyncValue<void>? getById,
  }) {
    return PeopleDetailState(
      people: people ?? this.people,
      getById: getById ?? this.getById,
    );
  }
}
