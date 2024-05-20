import 'dart:io';

class UserProfilePayload {
  final File? profileImageFile;
  final String? fullName;
  final List<String>? favouriteCategoriesId;
  final bool? isOnBoardingCompleted;

  UserProfilePayload({
    this.profileImageFile,
    this.fullName,
    this.favouriteCategoriesId,
    // This will only be called after the user completed onboarding
    // So, default to true
    this.isOnBoardingCompleted = true,
  });
}
