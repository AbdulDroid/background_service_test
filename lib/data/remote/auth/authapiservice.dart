import '../..//local/preferences.dart';
import '../../models/login_request.dart';
import '../../config/baseapi.dart';
import '../../models/user/user.dart';

abstract class AuthApiService {
  Future<User> login(LoginRequest loginRequest);
  Future<User> signUp(Map<String, dynamic> request);
}

class AuthApiServiceImpl extends BaseApi implements AuthApiService {
  final Preferences prefs;

  AuthApiServiceImpl({required this.prefs});

  @override
  Future<User> login(LoginRequest loginRequest) async {
    final res = await post("v1/login", data: loginRequest.toMap());

    final user = User.fromMap(res);

    if (user.token != null) {
      prefs.saveTokenToPrefs(value: user.token!);
    }
    return user;
  }

  @override
  Future<User> signUp(Map<String, dynamic> request) async {
    final res = await post("v1/signup",
        data: request,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    final user = User.fromMap(res);

    if (user.token != null) {
      prefs.saveTokenToPrefs(value: user.token!);
    }
    return user;
  }
}
