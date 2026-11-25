import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Education {
  const Education({
    this.id,
    required this.school,
    required this.degree,
    required this.startYear,
    required this.endYear,
    this.description = '',
    this.isActive = true,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String school;
  final String degree;
  final String startYear;
  final String endYear;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: true)
  final bool isActive;

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
