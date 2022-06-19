import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_info.dart';

class User extends Equatable {
  final String? token;
  final int? userId;
  final UserInfo? userInfo;

  const User({this.token, this.userId, this.userInfo});

  factory User.fromMap(Map<String, dynamic> data) => User(
        token: data['token'] as String?,
        userId: data['user_id'] as int?,
        userInfo: data['user_info'] == null
            ? null
            : UserInfo.fromMap(data['user_info'] as Map<String, dynamic>),
      );

  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [token, userId, userInfo];
}
