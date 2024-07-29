import 'package:flutter/material.dart';

@immutable
sealed class OrganizationProfileEvent {
  const OrganizationProfileEvent();
}

final class OnFetchOrganization extends OrganizationProfileEvent {
  final String organizationId;

  const OnFetchOrganization({required this.organizationId});
}

final class OnConnectOrganizationBankAccount extends OrganizationProfileEvent {
  final void Function(String accountLink) onSuccess;

  const OnConnectOrganizationBankAccount({required this.onSuccess});
}

final class OnFetchOrganizationCollaborations
    extends OrganizationProfileEvent {
  final String organizationId;

  const OnFetchOrganizationCollaborations({required this.organizationId});
    }