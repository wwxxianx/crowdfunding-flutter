import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  final ApiResult<List<Campaign>> recommendedCampaignsResult;
  final ApiResult<List<Campaign>> completedCampaignsResult;
  final ApiResult<List<Campaign>> closeToTargetCampaignsResult;
  final ApiResult<List<Campaign>> userInterestedCampaignsResult;
  final ApiResult<List<Organization>> organizationsResult;

  const HomeState({
    required this.recommendedCampaignsResult,
    required this.completedCampaignsResult,
    required this.organizationsResult,
    required this.closeToTargetCampaignsResult,
    required this.userInterestedCampaignsResult,
  });

  const HomeState.initial()
      : this(
          recommendedCampaignsResult: const ApiResultInitial(),
          completedCampaignsResult: const ApiResultInitial(),
          organizationsResult: const ApiResultInitial(),
          closeToTargetCampaignsResult: const ApiResultInitial(),
          userInterestedCampaignsResult: const ApiResultInitial(),
        );

  HomeState copyWith({
    ApiResult<List<Campaign>>? recommendedCampaignsResult,
    ApiResult<List<Campaign>>? completedCampaignsResult,
    ApiResult<List<Organization>>? organizationsResult,
    ApiResult<List<Campaign>>? closeToTargetCampaignsResult,
    ApiResult<List<Campaign>>? userInterestedCampaignsResult,
  }) {
    return HomeState(
      recommendedCampaignsResult:
          recommendedCampaignsResult ?? this.recommendedCampaignsResult,
      completedCampaignsResult:
          completedCampaignsResult ?? this.completedCampaignsResult,
      organizationsResult: organizationsResult ?? this.organizationsResult,
      closeToTargetCampaignsResult:
          closeToTargetCampaignsResult ?? this.closeToTargetCampaignsResult,
      userInterestedCampaignsResult:
          userInterestedCampaignsResult ?? this.userInterestedCampaignsResult,
    );
  }

  @override
  List<Object?> get props => [
        recommendedCampaignsResult,
        completedCampaignsResult,
        organizationsResult,
        closeToTargetCampaignsResult,
        userInterestedCampaignsResult,
      ];
}
