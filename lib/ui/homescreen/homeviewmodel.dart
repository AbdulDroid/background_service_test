import 'package:background_service_test/viewmodels/baseviewmodel.dart';

import '../../data/models/get_new_borns_response/newborn.dart';
import '../../data/remote/newborn/newbornrepository.dart';
import '../../di/servicelocator.dart';

class HomeViewModel extends BaseViewModel {
  bool _hasMore = true;
  int page = 1;

  final NewBornRepository _repository = getIT<NewBornRepository>();

  final List<NewBorn> _newborns = [];

  List<NewBorn> get newborns {
    return _newborns;
  }

  bool get hasMore {
    return _hasMore;
  }

  Future fetchNewBorn() async {
    if (isLoading || !_hasMore) {
      return;
    }
    setIsLoading(true);

    final url = "v1/newborns?page%5Bnumber%5D=$page&page%5Bsize%5D=25";
    final res = await _repository.getNewBorns(url);
    setIsLoading(false);
    page++;

    _newborns.addAll(res);

    if (res.length < 25) {
      _hasMore = false;
    }
    notifyListeners();
  }

  Future refresh() async {

    _hasMore = true;
    setIsLoading(false);

    page = 1;

    _newborns.clear();

    fetchNewBorn();
  }
}
