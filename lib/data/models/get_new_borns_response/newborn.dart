import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attributes.dart';
import 'links.dart';

class NewBorn extends Equatable {
  final String? id;
  final String? type;
  final Links? links;
  final Attributes? attributes;

  const NewBorn({this.id, this.type, this.links, this.attributes});

  factory NewBorn.fromMap(Map<String, dynamic> data) => NewBorn(
        id: data['id'] as String?,
        type: data['type'] as String?,
        links: data['links'] == null
            ? null
            : Links.fromMap(data['links'] as Map<String, dynamic>),
        attributes: data['attributes'] == null
            ? null
            : Attributes.fromMap(data['attributes'] as Map<String, dynamic>),
      );

  /// Parses the string and returns the resulting Json object as [Datum].
  factory NewBorn.fromJson(String data) {
    return NewBorn.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [id, type, links, attributes];
}
