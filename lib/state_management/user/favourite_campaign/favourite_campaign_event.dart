import 'package:flutter/material.dart';

@immutable
sealed class FavouriteCampaignEvent {}

final class OnAddCampaignToFavourite extends FavouriteCampaignEvent {
  final String campaignId;

  OnAddCampaignToFavourite(this.campaignId);
}

final class OnFetchFavouriteCampaigns extends FavouriteCampaignEvent{}

final class OnDeleteCampaignFromFavourite extends FavouriteCampaignEvent {
  final String campaignId;

  OnDeleteCampaignFromFavourite(this.campaignId);
}