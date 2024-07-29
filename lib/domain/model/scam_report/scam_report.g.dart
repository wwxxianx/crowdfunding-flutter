// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scam_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScamReport _$ScamReportFromJson(Map<String, dynamic> json) => ScamReport(
      id: json['id'] as String,
      description: json['description'] as String,
      campaign: json['campaign'] == null
          ? null
          : CampaignSummary.fromJson(json['campaign'] as Map<String, dynamic>),
      evidenceUrls: (json['evidenceUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      documentUrls: (json['documentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      resolution: json['resolution'] as String?,
      resolvedAt: json['resolvedAt'] as String?,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ScamReportToJson(ScamReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'campaign': instance.campaign,
      'evidenceUrls': instance.evidenceUrls,
      'documentUrls': instance.documentUrls,
      'status': instance.status,
      'resolution': instance.resolution,
      'resolvedAt': instance.resolvedAt,
      'createdAt': instance.createdAt,
    };
