import 'package:flutter/material.dart';

import '../../database/query/people_query.dart';
import '../../model/people/form_people_parameter.dart';
import '../../model/people/people_insertorupdate_response.dart';
import '../../model/people/people_model.dart';
import '../../model/people/people_summary_model.dart';
import '../../model/people/people_top_ten_model.dart';

class PeopleLocalService {
  const PeopleLocalService({
    required this.query,
  });

  final PeopleTableQuery query;

  Future<List<PeopleModel>> get() async {
    final result = await query.get();
    return result;
  }

  Future<List<PeopleTopTenModel>> getLatestTenPeople() async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.getLatestTenPeople();
    return result;
  }

  Future<List<PeopleSummaryModel>> getPeopleSummary() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await query.getPeopleSummary();
    return result;
  }

  Future<PeopleModel?> getById(String? peopleId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final result = await query.getById(peopleId);
    return result;
  }

  Future<PeopleInsertOrUpdateResponse> insertOrUpdate(FormPeopleParameter form) async {
    final result = await query.insertOrUpdatePeople(form);
    return result;
  }

  Future<int> delete(String peopleId) async {
    final result = await query.deletePeople(peopleId);
    return result;
  }
}
