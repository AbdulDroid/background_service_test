import 'dart:convert';

import 'package:equatable/equatable.dart';

class Attributes extends Equatable {
  final String? gender;
  final DateTime? gestation;
  final dynamic firstCryPushDate;
  final String? name;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Attributes({
    this.gender,
    this.gestation,
    this.firstCryPushDate,
    this.name,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Attributes.fromMap(Map<String, dynamic> data) => Attributes(
        gender: data['gender'] as String?,
        gestation: data['gestation'] == null
            ? null
            : DateTime.parse(data['gestation'] as String),
        firstCryPushDate: data['first_cry_push_date'] as dynamic,
        name: data['name'] as String?,
        userId: data['user_id'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  /// Parses the string and returns the resulting Json object as [Attributes].
  factory Attributes.fromJson(String data) {
    return Attributes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props {
    return [
      gender,
      gestation,
      firstCryPushDate,
      name,
      userId,
      createdAt,
      updatedAt,
    ];
  }
}
