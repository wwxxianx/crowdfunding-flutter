import 'dart:ffi';

import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:equatable/equatable.dart';

final class CampaignDetailsState extends Equatable with InputValidator {
  final int currentTabIndex;
  final ApiResult<Campaign> campaignResult;
  final ApiResult<Void> createCommentResult;

  // Reply
  final CampaignComment? selectedCommentToReply;
  final ApiResult<Void> createReplyResult;

  const CampaignDetailsState._({
    this.currentTabIndex = 0,
    this.campaignResult = const ApiResultLoading(),
    this.createCommentResult = const ApiResultInitial(),
    this.createReplyResult = const ApiResultInitial(),
    this.selectedCommentToReply,
  });

  const CampaignDetailsState.initial() : this._(currentTabIndex: 0);

  const CampaignDetailsState.fetchCampaignInProgress()
      : this._(
          campaignResult: const ApiResultLoading(),
        );

  CampaignDetailsState.fetchCampaignSuccess(Campaign data)
      : this._(
          campaignResult: ApiResultSuccess(data),
        );

  CampaignDetailsState.fetchCampaignFailed(String? errorMessage)
      : this._(
          campaignResult: ApiResultFailure(errorMessage),
        );

  CampaignDetailsState copyWith({
    int? currentTabIndex,
    ApiResult<Campaign>? campaignResult,
    ApiResult<Void>? createCommentResult,
    CampaignComment? selectedCommentToReply,
    ApiResult<Void>? createReplyResult,
  }) {
    return CampaignDetailsState._(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      campaignResult: campaignResult ?? this.campaignResult,
      createCommentResult: createCommentResult ?? this.createCommentResult,
      selectedCommentToReply: selectedCommentToReply,
      createReplyResult: createReplyResult ?? this.createReplyResult,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        campaignResult,
        createCommentResult,
        selectedCommentToReply,
        createReplyResult,
      ];
}
