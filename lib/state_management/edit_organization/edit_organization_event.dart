import 'dart:io';

import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:flutter/material.dart';

@immutable
sealed class EditOrganizationEvent {
  const EditOrganizationEvent();
}

final class OnInitOrganization extends EditOrganizationEvent {
  final Organization? organization;
  final String organizationId;

  const OnInitOrganization({
    required this.organization,
    required this.organizationId,
  });
}

final class OnFetchOrganizationMembers extends EditOrganizationEvent {
  final String organizationId;

  const OnFetchOrganizationMembers({required this.organizationId});
}

final class OnNameChanged extends EditOrganizationEvent {
  final String value;

  const OnNameChanged({required this.value});
}

final class OnEmailChanged extends EditOrganizationEvent {
  final String value;

  const OnEmailChanged({required this.value});
}

final class OnPhoneNumberChanged extends EditOrganizationEvent {
  final String value;

  const OnPhoneNumberChanged({required this.value});
}

final class OnImageFileChanged extends EditOrganizationEvent {
  final File file;
  const OnImageFileChanged({required this.file});
}

final class OnUpdateOrganization extends EditOrganizationEvent {
  final String organizationId;
  final VoidCallback onSuccess;

  const OnUpdateOrganization({
    required this.onSuccess,
    required this.organizationId,
  });
}
