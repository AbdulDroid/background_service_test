import '../../local/preferences.dart';
import '../../models/create_new_born_resquest/create_new_born_resquest.dart';
import '../../models/get_new_borns_response/newborn.dart';

import '../../config/baseapi.dart';
import '../../models/get_new_borns_response/get_new_borns_response.dart';

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
