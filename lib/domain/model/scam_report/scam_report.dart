import 'package:json_annotation/json_annotation.dart';

part 'scam_report.g.dart';

@JsonSerializable()
class ScamReport {
  final String id;
  final String description;

  const ScamReport({
    required this.id,
    required this.description,
  });

  factory ScamReport.fromJson(Map<String, dynamic> json) =>
      _$ScamReportFromJson(json);

  Map<String, dynamic> toJson() => _$ScamReportToJson(this);
}
