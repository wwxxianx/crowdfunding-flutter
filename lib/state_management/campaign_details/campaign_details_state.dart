import 'dart:io';

import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class CampaignDetailsState extends Equatable with InputValidator {
  final int currentTabIndex;
  final ApiResult<Campaign> campaignResult;
  final ApiResult<Unit> createCommentResult;
  final bool isShowingCommentBottomBar;

  // Reply
  final CampaignComment? selectedCommentToReply;
  final ApiResult<Unit> createReplyResult;

  // Scam Report
  final List<File> scamReportImageFiles;
  final List<File> scamReportDocumentFiles;
  final String? scamReportDescription;
  final ApiResult<ScamReport> createScamReportResult;

  const CampaignDetailsState._({
    this.currentTabIndex = 0,
    this.campaignResult = const ApiResultLoading(),
    this.createCommentResult = const ApiResultInitial(),
    this.createReplyResult = const ApiResultInitial(),
    this.selectedCommentToReply,
    this.isShowingCommentBottomBar = false,
    this.scamReportImageFiles = const [],
    this.scamReportDocumentFiles = const [],
    this.scamReportDescription,
    this.createScamReportResult = const ApiResultInitial(),
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
    ApiResult<Unit>? createCommentResult,
    CampaignComment? selectedCommentToReply,
    ApiResult<Unit>? createReplyResult,
    bool? isShowingCommentBottomBar,
    List<File>? scamReportImageFiles,
    List<File>? scamReportDocumentFiles,
    String? scamReportDescription,
    ApiResult<ScamReport>? createScamReportResult,
  }) {
    return CampaignDetailsState._(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      campaignResult: campaignResult ?? this.campaignResult,
      createCommentResult: createCommentResult ?? this.createCommentResult,
      selectedCommentToReply: selectedCommentToReply,
      createReplyResult: createReplyResult ?? this.createReplyResult,
      isShowingCommentBottomBar:
          isShowingCommentBottomBar ?? this.isShowingCommentBottomBar,
      scamReportImageFiles: scamReportImageFiles ?? this.scamReportImageFiles,
      scamReportDocumentFiles:
          scamReportDocumentFiles ?? this.scamReportDocumentFiles,
      scamReportDescription:
          scamReportDescription ?? this.scamReportDescription,
      createScamReportResult:
          createScamReportResult ?? this.createScamReportResult,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        campaignResult,
        createCommentResult,
        selectedCommentToReply,
        createReplyResult,
        isShowingCommentBottomBar,
        scamReportImageFiles,
        scamReportDocumentFiles,
        scamReportDescription,
        createScamReportResult,
      ];
}
