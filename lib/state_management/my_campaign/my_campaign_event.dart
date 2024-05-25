import 'package:flutter/material.dart';

@immutable
sealed class MyCampaignEvent {}

final class OnFetchMyCampaign extends MyCampaignEvent {
  final String userId;

  OnFetchMyCampaign(this.userId);
}
