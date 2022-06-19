import 'dart:convert';

import 'package:flutter/material.dart';

import 'source.dart';

@immutable
class Error {
  final int? status;
  final Source? source;
  final String? detail;

  const Error({this.status, this.source, this.detail});

  factory Error.fromMap(Map<String, dynamic> data) => Error(
        status: data['status'] as int?,
        source: data['source'] == null
            ? null
            : Source.fromMap(data['source'] as Map<String, dynamic>),
        detail: data['detail'] as String?,
      );

  /// Parses the string and returns the resulting Json object as [Error].
  factory Error.fromJson(String data) {
    return Error.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
