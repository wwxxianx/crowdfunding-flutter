import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update_recommendation.dart';
import 'package:equatable/equatable.dart';

final class CreateCampaignUpdateState extends Equatable {
  final String? titleError;
  final String? descriptionError;
  final ApiResult<CampaignUpdate> createUpdateResult;
  final ApiResult<CampaignUpdateRecommendation> updateRecommendationResult;

  const CreateCampaignUpdateState._({
    this.descriptionError,
    this.titleError,
    this.createUpdateResult = const ApiResultInitial(),
    this.updateRecommendationResult = const ApiResultInitial(),
  });

  const CreateCampaignUpdateState.initial() : this._();

  CreateCampaignUpdateState copyWith({
    String? titleError,
    String? descriptionError,
    ApiResult<CampaignUpdate>? createUpdateResult,
    ApiResult<CampaignUpdateRecommendation>? updateRecommendationResult,
  }) {
    return CreateCampaignUpdateState._(
      titleError: titleError ?? this.titleError,
      descriptionError: descriptionError ?? this.descriptionError,
      createUpdateResult: createUpdateResult ?? this.createUpdateResult,
      updateRecommendationResult:
          updateRecommendationResult ?? this.updateRecommendationResult,
    );
  }

  @override
  List<Object?> get props => [
        titleError,
        descriptionError,
        createUpdateResult,
        updateRecommendationResult,
      ];
}
