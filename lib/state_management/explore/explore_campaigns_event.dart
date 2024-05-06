import 'package:flutter/material.dart';

@immutable
sealed class ExploreCampaignsEvent {}

final class OnViewChange extends ExploreCampaignsEvent {
  final bool isGridView;
  OnViewChange(this.isGridView);
}
