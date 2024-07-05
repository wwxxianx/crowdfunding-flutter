import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  final ApiResult<List<Campaign>> recommendedCampaignsResult;
  final ApiResult<List<Campaign>> completedCampaignsResult;
  final ApiResult<List<Organization>> organizationsResult;

  const HomeState._({
    required this.recommendedCampaignsResult,
    required this.completedCampaignsResult,
    required this.organizationsResult,
  });

  const HomeState.initial()
      : this._(
          recommendedCampaignsResult: const ApiResultInitial(),
          completedCampaignsResult: const ApiResultInitial(),
          organizationsResult: const ApiResultInitial(),
        );

  HomeState copyWith({
    ApiResult<List<Campaign>>? recommendedCampaignsResult,
    ApiResult<List<Campaign>>? completedCampaignsResult,
    ApiResult<List<Organization>>? organizationsResult,
  }) {
    return HomeState._(
      recommendedCampaignsResult:
          recommendedCampaignsResult ?? this.recommendedCampaignsResult,
      completedCampaignsResult:
          completedCampaignsResult ?? this.completedCampaignsResult,
      organizationsResult: organizationsResult ?? this.organizationsResult,
    );
  }

  @override
  List<Object?> get props => [
        recommendedCampaignsResult,
        completedCampaignsResult,
        organizationsResult,
      ];
}
