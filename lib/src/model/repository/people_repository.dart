import 'package:dartz/dartz.dart';
import 'package:drift/native.dart';

import '../../utils/utils.dart';
import '../model/people/people_form_parameter.dart';
import '../model/people/people_model.dart';
import '../model/people/people_top_ten_model.dart';
import '../model/people/peoples_model.dart';
import '../service/local/people_local_service.dart';

class PeopleRepository {
  const PeopleRepository({
    required this.peopleLocalService,
  });
  final PeopleLocalService peopleLocalService;

  Future<Either<Failure, int>> insertOrUpdate(PeopleFormParameter form) async {
    try {
      final result = await peopleLocalService.insertOrUpdate(form);
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> delete(String peopleId) async {
    try {
      final result = await peopleLocalService.delete(peopleId);
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<PeopleTopTenModel>>> getLatestTenPeople() async {
    try {
      final result = await peopleLocalService.getLatestTenPeople();
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<PeoplesModel>>> getPeoples() async {
    try {
      final result = await peopleLocalService.getPeoples();
      return Right(result);
    } on SqliteException catch (exception) {
      throw Left(SqliteFailure(exception: exception));
    } catch (e) {
      throw Left(UncaughtFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, PeopleModel?>> getById(String peopleId) async {
    try {
      final result = await peopleLocalService.getById(peopleId);
      return Right(result);
    } on SqliteException catch (exception) {
      return Left(SqliteFailure(exception: exception));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
