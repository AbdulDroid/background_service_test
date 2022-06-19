import '../../models/login_request.dart';
import '../../remote/auth/authapiservice.dart';

import '../../models/user/user.dart';

abstract class AuthRepository {
  Future<User> login(LoginRequest request);
  Future<User> signUp(Map<String, dynamic> request);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService apiService;

  AuthRepositoryImpl({required this.apiService});

  @override
  Future<User> login(LoginRequest request) async {
    return await apiService.login(request);
  }

  @override
  Future<User> signUp(Map<String, dynamic> request) async {
    return await apiService.signUp(request);
  }
}
