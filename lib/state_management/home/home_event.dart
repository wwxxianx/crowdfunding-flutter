import 'package:flutter/material.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class OnFetchRecommendedCampaigns extends HomeEvent {}