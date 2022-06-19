import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? userConsent;
  final bool? isActiveListening;
  final dynamic newborn;

  const UserInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.userConsent,
    this.isActiveListening,
    this.newborn,
  });

  factory UserInfo.fromMap(Map<String, dynamic> data) => UserInfo(
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        email: data['email'] as String?,
        userConsent: data['user_consent'] as bool?,
        isActiveListening: data['is_active_listening'] as bool?,
        newborn: data['newborn'] as dynamic,
      );

  /// Parses the string and returns the resulting Json object as [UserInfo].
  factory UserInfo.fromJson(String data) {
    return UserInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      email,
      userConsent,
      isActiveListening,
      newborn,
    ];
  }
}
