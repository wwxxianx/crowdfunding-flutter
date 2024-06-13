import 'package:flutter/material.dart';

@immutable
sealed class ConnectedAccountEvent {
  const ConnectedAccountEvent();
}

final class OnFetchConnectedAccount extends ConnectedAccountEvent {
  final String? stripeConnectAccountId;

  const OnFetchConnectedAccount({required this.stripeConnectAccountId});
}

final class OnUpdateConnectAccount extends ConnectedAccountEvent {
  final String stripeConnectAccountId;
  final void Function(String onboardLink) onSuccess;

  const OnUpdateConnectAccount({required this.stripeConnectAccountId, required this.onSuccess,});
}
