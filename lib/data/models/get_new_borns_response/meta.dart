import 'dart:convert';

import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int? recordCount;

  const Meta({this.recordCount});

  factory Meta.fromMap(Map<String, dynamic> data) => Meta(
        recordCount: data['record_count'] as int?,
      );

  /// Parses the string and returns the resulting Json object as [Meta].
  factory Meta.fromJson(String data) {
    return Meta.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [recordCount];
}
