import 'dart:io';

import 'package:equatable/equatable.dart';

final class PersonalOnboardingState extends Equatable {
  final String fullName;
  final String? fullNameError;
  final File? profileImageFile;
  final List<String> selectedCategoriesId;
  final bool isUpdatingProfile;
  final String? updateProfileError;

  const PersonalOnboardingState._({
    this.fullName = "",
    this.fullNameError,
    this.profileImageFile,
    this.selectedCategoriesId = const [],
    this.isUpdatingProfile = false,
    this.updateProfileError,
  });

  const PersonalOnboardingState.initial() : this._();

  PersonalOnboardingState copyWith({
    String? fullName,
    String? fullNameError,
    File? profileImageFile,
    List<String>? selectedCategoriesId,
    bool isUpdatingProfile = false,
    String? updateProfileError,
  }) {
    return PersonalOnboardingState._(
      fullName: fullName ?? this.fullName,
      fullNameError: fullNameError ?? this.fullNameError,
      profileImageFile: profileImageFile ?? this.profileImageFile,
      selectedCategoriesId: selectedCategoriesId ?? this.selectedCategoriesId,
      isUpdatingProfile: isUpdatingProfile,
      updateProfileError: updateProfileError ?? this.updateProfileError,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        fullNameError,
        profileImageFile,
        selectedCategoriesId,
        isUpdatingProfile,
        updateProfileError,
      ];
}
