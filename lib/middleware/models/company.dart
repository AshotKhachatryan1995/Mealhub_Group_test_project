import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';

@JsonSerializable()
class Company {
  Company({required this.name, required this.catchPhrase, required this.bs});

  final String name;
  final String catchPhrase;
  final String bs;

  factory Company.fromJson(Map<String, dynamic> data) =>
      _$CompanyFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
