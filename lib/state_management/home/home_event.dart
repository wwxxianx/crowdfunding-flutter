import 'package:flutter/material.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}
final class OnInitData extends HomeEvent {}

final class OnFetchRecommendedCampaigns extends HomeEvent {}

final class OnFetchOrganizations extends HomeEvent {}

final class OnFetchSuccessfulCampaigns extends HomeEvent {}

final class TestPayment extends HomeEvent {}