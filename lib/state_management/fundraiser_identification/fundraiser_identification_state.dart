import 'dart:io';

import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:equatable/equatable.dart';

final class FundraiserIdentificationState extends Equatable {
  final ApiResult<CampaignFundraiser> fundraiserResult;
  final ApiResult<CampaignFundraiser> updateFundraiserResult;
  final String idNumberText;
  final File? signatureFile;

  const FundraiserIdentificationState._({
    this.fundraiserResult = const ApiResultInitial(),
    this.updateFundraiserResult = const ApiResultInitial(),
    this.idNumberText = '',
    this.signatureFile,
  });

  const FundraiserIdentificationState.initial() : this._();

  FundraiserIdentificationState copyWith({
    ApiResult<CampaignFundraiser>? fundraiserResult,
    ApiResult<CampaignFundraiser>? updateFundraiserResult,
    String? idNumberText,
    File? signatureFile,
  }) {
    return FundraiserIdentificationState._(
      fundraiserResult: fundraiserResult ?? this.fundraiserResult,
      idNumberText: idNumberText ?? this.idNumberText,
      signatureFile: signatureFile ?? this.signatureFile,
      updateFundraiserResult: updateFundraiserResult ?? this.updateFundraiserResult,
    );
  }

  @override
  List<Object?> get props => [
        fundraiserResult, 
        idNumberText,
        signatureFile,
        updateFundraiserResult,
  ];
}
