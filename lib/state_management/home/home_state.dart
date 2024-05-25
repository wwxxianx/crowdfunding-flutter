import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

// @immutable
// sealed class HomeState {}

// final class HomeInitial extends HomeState {}

// final class FetchRecommendedCampaignsLoading extends HomeState {}

// final class FetchRecommendedCampaignsError extends HomeState {
//   final String message;
//   FetchRecommendedCampaignsError({
//     required this.message,
//   });
// }

// final class FetchRecommendedCampaignsSuccess extends HomeState {
//   final List<Campaign> campaigns;

//   FetchRecommendedCampaignsSuccess({
//     required this.campaigns,
//   });
// }

final class HomeState extends Equatable {
  final ApiResult<List<Campaign>> recommendedCampaignsResult;

  const HomeState._({
    required this.recommendedCampaignsResult,
  });

  const HomeState.initial()
      : this._(recommendedCampaignsResult: const ApiResultInitial());

  HomeState copyWith({
    ApiResult<List<Campaign>>? recommendedCampaignsResult,
  }) {
    return HomeState._(
      recommendedCampaignsResult:
          recommendedCampaignsResult ?? this.recommendedCampaignsResult,
    );
  }

  @override
  List<Object?> get props => [recommendedCampaignsResult];
}
