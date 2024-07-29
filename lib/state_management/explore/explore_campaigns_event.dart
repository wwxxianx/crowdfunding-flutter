import 'package:flutter/material.dart';

@immutable
sealed class ExploreCampaignsEvent {
  const ExploreCampaignsEvent();
}

final class OnViewChange extends ExploreCampaignsEvent {
  final bool isGridView;
  const OnViewChange({required this.isGridView});
}

final class OnFetchCampaigns extends ExploreCampaignsEvent {}

final class OnSelectCampaignCategory extends ExploreCampaignsEvent {
  final String categoryId;

  const OnSelectCampaignCategory({required this.categoryId});
}

final class OnSelectStateAndRegion extends ExploreCampaignsEvent {
  final String stateId;

  const OnSelectStateAndRegion({required this.stateId});
}

final class OnSearchQueryChanged extends ExploreCampaignsEvent {
  final String searchQuery;

  const OnSearchQueryChanged({required this.searchQuery});
}

final class OnRefreshCampaigns extends ExploreCampaignsEvent {}