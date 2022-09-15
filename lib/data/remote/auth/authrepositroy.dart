import 'package:background_service_test/data/models/login_request.dart';
import 'package:background_service_test/data/models/user/user.dart';
import 'package:background_service_test/data/remote/auth/authapiservice.dart';

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
