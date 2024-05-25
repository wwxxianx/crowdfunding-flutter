import 'package:flutter/material.dart';

@immutable
sealed class DonateEvent {}

final class OnCreateDonation extends DonateEvent {
  final int amount;
  final String campaignId;
  final bool isAnonymous;
  final BuildContext context;

  OnCreateDonation({
    required this.amount,
    required this.campaignId,
    required this.isAnonymous,
    required this.context,
  });
}
