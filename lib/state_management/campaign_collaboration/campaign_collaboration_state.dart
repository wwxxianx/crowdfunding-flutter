import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:equatable/equatable.dart';

final class CampaignCollaborationState extends Equatable {
  final bool isCollarationNull;
  final ApiResult<Collaboration> campaignCollaborationResult;
  final ApiResult<Collaboration> submitCollaborationResult;

  const CampaignCollaborationState._({
    this.isCollarationNull = false,
    this.campaignCollaborationResult = const ApiResultInitial(),
    this.submitCollaborationResult = const ApiResultInitial(),
  });

  const CampaignCollaborationState.initial() : this._();

  CampaignCollaborationState copyWith({
    ApiResult<Collaboration>? campaignCollaborationResult,
    ApiResult<Collaboration>? submitCollaborationResult,
    bool? isCollarationNull,
  }) {
    return CampaignCollaborationState._(
      campaignCollaborationResult:
          campaignCollaborationResult ?? this.campaignCollaborationResult,
      submitCollaborationResult:
          submitCollaborationResult ?? this.submitCollaborationResult,
      isCollarationNull: isCollarationNull ?? this.isCollarationNull,
    );
  }

  @override
  List<Object?> get props => [
        isCollarationNull,
        campaignCollaborationResult,
        submitCollaborationResult,
      ];
}
