import 'dart:io';

class UserProfilePayload {
  final File? profileImageFile;
  final String? fullName;
  final String? address;
  final String? identityNumber;
  final String? phoneNumber;
  final String? onesignalId;
  final List<String>? favouriteCategoriesId;
  final bool? isOnBoardingCompleted;

  UserProfilePayload({
    this.profileImageFile,
    this.fullName,
    this.favouriteCategoriesId,
    this.address,
    // This will only be called after the user completed onboarding
    // So, default to true
    this.isOnBoardingCompleted = true,
    this.phoneNumber,
    this.identityNumber,
    this.onesignalId,
  });
}
