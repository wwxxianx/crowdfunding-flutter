import 'package:flutter/material.dart';

@immutable
sealed class OrganizationProfileEvent {
  const OrganizationProfileEvent();
}

final class OnFetchOrganization extends OrganizationProfileEvent {
  final String organizationId;

  const OnFetchOrganization({required this.organizationId});
}
