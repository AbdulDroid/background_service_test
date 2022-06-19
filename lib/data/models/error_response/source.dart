import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Source {
  final String? pointer;

  const Source({this.pointer});

  factory Source.fromMap(Map<String, dynamic> data) => Source(
        pointer: data['pointer'] as String?,
      );

  /// Parses the string and returns the resulting Json object as [Source].
  factory Source.fromJson(String data) {
    return Source.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
