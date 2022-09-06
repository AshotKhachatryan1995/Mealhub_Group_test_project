import 'package:json_annotation/json_annotation.dart';
part 'geo.g.dart';

@JsonSerializable()
class Geo {
  Geo({required this.lat, required this.lng});

  final String lat;
  final String lng;

  factory Geo.fromJson(Map<String, dynamic> data) => _$GeoFromJson(data);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}
