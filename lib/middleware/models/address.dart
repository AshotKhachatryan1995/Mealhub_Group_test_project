import 'package:json_annotation/json_annotation.dart';

import 'geo.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo});

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  factory Address.fromJson(Map<String, dynamic> data) =>
      _$AddressFromJson(data);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
