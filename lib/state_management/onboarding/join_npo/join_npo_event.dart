import 'package:flutter/material.dart';

@immutable
sealed class JoinNPOEvent {
  const JoinNPOEvent();
}

final class OnCodeTextChanged extends JoinNPOEvent {
  final String value;

  const OnCodeTextChanged(this.value);
}

final class OnFetchOrganization extends JoinNPOEvent {
  final VoidCallback onSuccess;

  const OnFetchOrganization({
    required this.onSuccess,
  });
}

final class OnJoinOrganization extends JoinNPOEvent {
  final String organizationId;
  final VoidCallback onSuccess;

  const OnJoinOrganization({
    required this.onSuccess,
    required this.organizationId,
  });
}

// Continue to the app directly
final class OnboardCompleteWithoutJoinNPO extends JoinNPOEvent {
  final VoidCallback onSuccess;

  const OnboardCompleteWithoutJoinNPO({
    required this.onSuccess,
  });
}
