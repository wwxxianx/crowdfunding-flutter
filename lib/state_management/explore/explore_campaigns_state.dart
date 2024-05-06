import 'package:flutter/material.dart';

@immutable
sealed class ExploreCampaignsState {
  const ExploreCampaignsState();
}

final class ExploreCampaignsInitial extends ExploreCampaignsState {}

final class ExploreCampaignsGridView extends ExploreCampaignsState {}

final class ExploreCampaignsListView extends ExploreCampaignsState {}
