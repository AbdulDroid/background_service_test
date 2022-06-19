import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'newborn.dart';
import 'links.dart';
import 'meta.dart';

class GetNewBornsResponse extends Equatable {
  final List<NewBorn>? data;
  final Meta? meta;
  final Links? links;

  const GetNewBornsResponse({this.data, this.meta, this.links});

  factory GetNewBornsResponse.fromMap(Map<String, dynamic> data) {
    return GetNewBornsResponse(
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => NewBorn.fromMap(e as Map<String, dynamic>))
          .toList(),
      meta: data['meta'] == null
          ? null
          : Meta.fromMap(data['meta'] as Map<String, dynamic>),
      links: data['links'] == null
          ? null
          : Links.fromMap(data['links'] as Map<String, dynamic>),
    );
  }

  /// Parses the string and returns the resulting Json object as [GetNewBornsResponse].
  factory GetNewBornsResponse.fromJson(String data) {
    return GetNewBornsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [data, meta, links];
}
