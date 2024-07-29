// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scam_report.g.dart';

enum ScamReportStatus {
  PENDING,
  UNDER_REVIEW,
  RESOLVED,
  REJECTED;

  String get displayTitle {
    switch (this) {
      case ScamReportStatus.PENDING:
        return "Pending";
      case ScamReportStatus.UNDER_REVIEW:
        return "Under Review";
      case ScamReportStatus.RESOLVED:
        return "Resolved";
      case ScamReportStatus.REJECTED:
        return "Rejected";
    }
  }

  CustomChipStyle get chipStyle {
    switch (this) {
      case ScamReportStatus.PENDING:
        return CustomChipStyle.slate;
      case ScamReportStatus.UNDER_REVIEW:
        return CustomChipStyle.amber;
      case ScamReportStatus.RESOLVED:
        return CustomChipStyle.green;
      case ScamReportStatus.REJECTED:
        return CustomChipStyle.red;
    }
  }
}

@JsonSerializable()
class ScamReport {
  final String id;
  final String description;
  final CampaignSummary? campaign;
  final List<String> evidenceUrls;
  final List<String> documentUrls;
  final String status;
  final String? resolution;
  final String? resolvedAt;
  final String createdAt;

  ScamReportStatus get statusEnum {
    try {
      return ScamReportStatus.values.byName(status);
    } catch (e) {
      return ScamReportStatus.PENDING;
    }
  }

  const ScamReport({
    required this.id,
    required this.description,
    this.campaign,
    required this.evidenceUrls,
    required this.documentUrls,
    required this.status,
    this.resolution,
    this.resolvedAt,
    required this.createdAt,
  });

  factory ScamReport.fromJson(Map<String, dynamic> json) =>
      _$ScamReportFromJson(json);

  Map<String, dynamic> toJson() => _$ScamReportToJson(this);
}
