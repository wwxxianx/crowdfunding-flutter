import 'dart:io';

import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:flutter/material.dart';

@immutable
sealed class FundraiserIdentificationEvent {
  const FundraiserIdentificationEvent();
}

final class OnFetchCampaignFundraiser extends FundraiserIdentificationEvent {
  final String campaignId;
  final void Function(CampaignFundraiser? data)? onSuccess;
  const OnFetchCampaignFundraiser({
    required this.campaignId,
    this.onSuccess,
  });
}

final class OnIdNumberChanged extends FundraiserIdentificationEvent {
  final String value;

  const OnIdNumberChanged({
    required this.value,
  });
}

final class OnSignatureFileChanged extends FundraiserIdentificationEvent {
  final File file;

  const OnSignatureFileChanged({
    required this.file,
  });
}

final class OnUpdateFundraiser extends FundraiserIdentificationEvent {
  final String campaignId;

  const OnUpdateFundraiser({
    required this.campaignId,
  });
}
