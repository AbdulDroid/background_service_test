import 'dart:convert';

import 'package:equatable/equatable.dart';

class Attributes extends Equatable {
  final String? name;
  final DateTime? gestation;
  final String? gender;

  const Attributes({this.name, this.gestation, this.gender});

  Map<String, dynamic> toMap() => {
        'name': name,
        'gestation': gestation?.toIso8601String(),
        'gender': gender,
      };

  /// Converts [Attributes] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [name, gestation, gender];
}
