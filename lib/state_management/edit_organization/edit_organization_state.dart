import 'dart:io';

import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class EditOrganizationState extends Equatable {
  final ApiResult<Organization> organizationResult;
  final ApiResult<List<UserModel>> membersResult;
  final String nameText;
  final String emailText;
  final String contactPhoneNumberText;
  final File? imageFile;
  final bool isUpdatingOrganization;
  final String? updateOrganizationError;

  const EditOrganizationState._({
    required this.organizationResult,
    required this.nameText,
    required this.emailText,
    required this.contactPhoneNumberText,
    required this.membersResult,
    this.imageFile,
    this.isUpdatingOrganization = false,
    this.updateOrganizationError,
  });

  const EditOrganizationState.initial()
      : this._(
            organizationResult: const ApiResultInitial(),
            membersResult: const ApiResultInitial(),
            nameText: '',
            emailText: '',
            contactPhoneNumberText: '');

  EditOrganizationState copyWith({
    ApiResult<Organization>? organizationResult,
    ApiResult<List<UserModel>>? membersResult,
    String? nameText,
    String? emailText,
    String? contactPhoneNumberText,
    File? imageFile,
    bool? isUpdatingOrganization,
    String? updateOrganizationError,
  }) {
    return EditOrganizationState._(
      organizationResult: organizationResult ?? this.organizationResult,
      membersResult: membersResult ?? this.membersResult,
      nameText: nameText ?? this.nameText,
      emailText: emailText ?? this.emailText,
      contactPhoneNumberText:
          contactPhoneNumberText ?? this.contactPhoneNumberText,
      imageFile: imageFile ?? this.imageFile,
      isUpdatingOrganization:
          isUpdatingOrganization ?? this.isUpdatingOrganization,
      updateOrganizationError:
          updateOrganizationError ?? this.updateOrganizationError,
    );
  }

  @override
  List<Object?> get props => [
        organizationResult,
        nameText,
        emailText,
        contactPhoneNumberText,
        membersResult,
        imageFile,
        isUpdatingOrganization,
        updateOrganizationError,
      ];
}
