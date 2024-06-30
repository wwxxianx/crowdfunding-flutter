import 'package:json_annotation/json_annotation.dart';

part 'campaign_fundraiser.g.dart';

@JsonSerializable()
class CampaignFundraiser {
  @JsonKey(name: 'id')
  final String campaignId;
  final String? fundraiserIdentityNumber;
  final String fundraiserIdentificationStatus;
  final String? fundraiserIdentificationRejectReason;
  @JsonKey(name: 'fundraiserSignatureUrl')
  final String? fundraiserSignaturFileUrl;

  const CampaignFundraiser({
    required this.campaignId,
    this.fundraiserIdentityNumber,
    required this.fundraiserIdentificationStatus,
    this.fundraiserIdentificationRejectReason,
    this.fundraiserSignaturFileUrl,
  });

  factory CampaignFundraiser.fromJson(Map<String, dynamic> json) =>
      _$CampaignFundraiserFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignFundraiserToJson(this);
}
