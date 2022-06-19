import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class CreateNewBornResquest extends Equatable {
  final Data? data;

  const CreateNewBornResquest({this.data});

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// Converts [CreateNewBornResquest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [data];
}
