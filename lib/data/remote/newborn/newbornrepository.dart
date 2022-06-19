import '../../models/create_new_born_resquest/create_new_born_resquest.dart';
import '../../models/get_new_borns_response/newborn.dart';
import '../../remote/newborn/newbornapiservice.dart';

abstract class NewBornRepository {
  Future<NewBorn> createNewBorn(CreateNewBornResquest resquest);
  Future<List<NewBorn>> getNewBorns(String paginatedUrl);
}

class NewBornRepositoryImpl implements NewBornRepository {
  final NewBornApiService apiService;

  NewBornRepositoryImpl({required this.apiService});

  @override
  Future<NewBorn> createNewBorn(CreateNewBornResquest resquest) async {
    return await apiService.createNewBorn(resquest);
  }

  @override
  Future<List<NewBorn>> getNewBorns(String paginatedUrl) async {
    return await apiService.getNewBorns(paginatedUrl);
  }
}
