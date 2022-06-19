import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String password;
  final String email;

  const LoginRequest({required this.password, required this.email});

  Map<String, dynamic> toMap() => {
        'password': password,
        'email': email,
      };

  /// Converts [LoginRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [password, email];
}
