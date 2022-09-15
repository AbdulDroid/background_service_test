import 'package:background_service_test/data/config/baseapi.dart';
import 'package:background_service_test/data/local/preferences.dart';
import 'package:background_service_test/data/models/create_new_born_resquest/create_new_born_resquest.dart';
import 'package:background_service_test/data/models/get_new_borns_response/get_new_borns_response.dart';
import 'package:background_service_test/data/models/get_new_borns_response/newborn.dart';

abstract class NewBornApiService {
  Future<NewBorn> createNewBorn(CreateNewBornResquest resquest);
  Future<List<NewBorn>> getNewBorns(String paginatedUrl);
}

class NewBornApiServiceImpl extends BaseApi implements NewBornApiService {
  final Preferences prefs;

  NewBornApiServiceImpl({required this.prefs});

  @override
  Future<NewBorn> createNewBorn(CreateNewBornResquest resquest) async {
    final res = await post("", data: resquest.toMap(), headers: {
      "Authorization": "Bearer ${await prefs.getTokenFromPrefs()}"
    });

    return NewBorn.fromMap(res);
  }

  @override
  Future<List<NewBorn>> getNewBorns(String paginatedUrl) async {
    final res = await get(paginatedUrl, headers: {
      "Authorization": "Bearer ${await prefs.getTokenFromPrefs()}"
    });

    final newBorns = GetNewBornsResponse.fromMap(res).data;

    return newBorns ?? [];
  }
}
