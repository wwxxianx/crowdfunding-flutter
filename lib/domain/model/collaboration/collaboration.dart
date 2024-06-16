import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collaboration.g.dart';

@JsonSerializable()
class Collaboration {
  final String id;
  final CampaignSummary campaign;
  final Organization? organization;
  final double reward;
  final String createdAt;
  final String updatedAt;
  final bool isCancelled;
  final String? cancelledById;
  final String? cancellationReason;
  final String? cancelledAt;

  const Collaboration({
    required this.id,
    required this.campaign,
    this.organization,
    required this.reward,
    required this.createdAt,
    required this.updatedAt,
    this.isCancelled = false,
    this.cancelledById,
    this.cancellationReason,
    this.cancelledAt,
  });

  factory Collaboration.fromJson(Map<String, dynamic> json) =>
      _$CollaborationFromJson(json);

  Map<String, dynamic> toJson() => _$CollaborationToJson(this);

  static final samples = [
    Collaboration(
      id: '1',
      campaign: CampaignSummary.samples[0],
      organization: Organization.samples.first,
      reward: 0.01,
      createdAt: '2022-10-01T00:00:00.000Z',
      updatedAt: '2022-10-01T00:00:00.000Z',
      isCancelled: true,
    ),
  ];
}
