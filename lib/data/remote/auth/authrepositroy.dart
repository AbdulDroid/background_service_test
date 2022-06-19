import 'package:ubenwa_abdulrahman/data/models/login_request.dart';
import 'package:ubenwa_abdulrahman/data/models/user/user.dart';
import 'package:ubenwa_abdulrahman/data/remote/auth/authapiservice.dart';

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
