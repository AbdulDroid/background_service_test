import 'package:background_service_test/viewmodels/baseviewmodel.dart';
import '../../data/config/exceptions.dart';
import '../../data/remote/auth/authrepositroy.dart';
import '../../utils/navigationservice.dart';
import '../../utils/router.dart';

import '../../di/servicelocator.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthRepository _repository = getIT<AuthRepository>();
  final NavigationHandler _handler = getIT<NavigationHandler>();

  Future signup(
      String name, String email, String password, Function onError) async {
    setIsLoading(true);
    final names = name.split(" ");
    final dataMap = {
      "first_name": names[0],
      "last_name": names.length >= 2 ? names[1] : null,
      "email": email,
      "password": password,
      "password_confirmation": password
    };

    try {
      await _repository.signUp(dataMap);
      setIsLoading(false);
      _handler.pushNamedAndRemoveUntil(Routes.HOME);
    } on CustomException catch (e) {
      setIsLoading(false);
      onError(e.message);
    }
  }
}
