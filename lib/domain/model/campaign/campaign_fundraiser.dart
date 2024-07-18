import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_fundraiser.g.dart';

@JsonSerializable()
class CampaignFundraiser {
  @JsonKey(name: 'id')
  final String campaignId;
  @JsonKey(name: 'fundraiserSignatureUrl')
  final String? fundraiserSignaturFileUrl;
  final UserModel user;

  const CampaignFundraiser({
    required this.campaignId,
    this.fundraiserSignaturFileUrl,
    required this.user,
  });

  factory CampaignFundraiser.fromJson(Map<String, dynamic> json) =>
      _$CampaignFundraiserFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignFundraiserToJson(this);
}
