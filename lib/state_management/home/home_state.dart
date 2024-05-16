import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:flutter/material.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchRecommendedCampaignsLoading extends HomeState {}

final class FetchRecommendedCampaignsError extends HomeState {
  final String message;
  FetchRecommendedCampaignsError({
    required this.message,
  });
}

final class FetchRecommendedCampaignsSuccess extends HomeState {
  final List<Campaign> campaigns;

  FetchRecommendedCampaignsSuccess({
    required this.campaigns,
  });
}
