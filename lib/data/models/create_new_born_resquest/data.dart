import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attributes.dart';

class Data extends Equatable {
  final String? type;
  final Attributes? attributes;

  const Data({this.type, this.attributes});

  Map<String, dynamic> toMap() => {
        'type': type,
        'attributes': attributes?.toMap(),
      };

  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [type, attributes];
}
