import 'package:ubenwa_abdulrahman/viewmodels/baseviewmodel.dart';

import '../../data/models/login_request.dart';
import '../../data/remote/auth/authrepositroy.dart';
import '../../utils/navigationservice.dart';
import '../../data/config/exceptions.dart';
import '../../di/servicelocator.dart';
import '../../utils/router.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository _repository = getIT<AuthRepository>();
  final NavigationHandler _handler = getIT<NavigationHandler>();

  Future login(String email, String password, Function onError) async {
    setIsLoading(true);
    try {
      await _repository.login(LoginRequest(password: password, email: email));
      setIsLoading(false);
      _handler.popAndPushNamed(Routes.HOME);
    } on CustomException catch (e) {
      setIsLoading(false);
      onError(e.message);
    }
  }
}
