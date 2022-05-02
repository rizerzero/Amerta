import '../../database/query/people_query.dart';
import '../../model/people/people_form_parameter.dart';
import '../../model/people/people_model.dart';
import '../../model/people/people_top_ten_model.dart';
import '../../model/people/peoples_model.dart';

class PeopleLocalService {
  const PeopleLocalService({
    required this.query,
  });

  final PeopleTableQuery query;

  Future<int> insertOrUpdate(PeopleFormParameter form) async {
    final result = await query.insertOrUpdatePeople(form);
    return result;
  }

  Future<int> delete(String peopleId) async {
    final result = await query.deletePeople(peopleId);
    return result;
  }

  Future<List<PeopleTopTenModel>> getLatestTenPeople() async {
    final result = await query.getLatestTenPeople();
    return result;
  }

  Future<List<PeoplesModel>> getPeoples() async {
    final result = await query.getPeoples();
    return result;
  }

  Future<PeopleModel?> getById(String peopleId) async {
    final result = await query.getById(peopleId);
    return result;
  }
}
