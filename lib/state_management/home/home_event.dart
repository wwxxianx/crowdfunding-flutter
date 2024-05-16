import 'package:flutter/material.dart';

@immutable
sealed class HomeEvent {}

final class FetchRecommendedCampaigns extends HomeEvent {}