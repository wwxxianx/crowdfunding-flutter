import 'package:flutter/material.dart';

@immutable
sealed class ExploreCollaborationEvent {
  const ExploreCollaborationEvent();
}

final class OnFetchPendingCollaborations extends ExploreCollaborationEvent {}

final class OnTakeCollaboration extends ExploreCollaborationEvent {
  final String collaborationId;
  final String organizationId;
  final VoidCallback onSuccess;

  const OnTakeCollaboration({
    required this.collaborationId,
    required this.organizationId,
    required this.onSuccess,
  });
}
