import 'dart:convert';

import 'package:flutter/material.dart';

import 'error.dart';

@immutable
class ErrorResponse {
  final List<Error>? errors;

  const ErrorResponse({this.errors});

  factory ErrorResponse.fromMap(Map<String, dynamic> data) => ErrorResponse(
        errors: (data['errors'] as List<dynamic>?)
            ?.map((e) => Error.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  /// Parses the string and returns the resulting Json object as [ErrorResponse].
  factory ErrorResponse.fromJson(String data) {
    return ErrorResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
