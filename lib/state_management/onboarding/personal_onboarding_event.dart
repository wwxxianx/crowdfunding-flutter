import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
sealed class PersonalOnboardingEvent {
  const PersonalOnboardingEvent();
}

final class OnFullNameChanged extends PersonalOnboardingEvent {
  final String fullName;

  const OnFullNameChanged({required this.fullName});
}

final class OnProfileImageFileChanged extends PersonalOnboardingEvent {
  final File file;

  const OnProfileImageFileChanged({required this.file});
}

final class OnSelectCategories extends PersonalOnboardingEvent {
  final String categoryId;

  const OnSelectCategories({required this.categoryId});
}

final class OnUpdateProfile extends PersonalOnboardingEvent {
  final VoidCallback onSuccess;

  const OnUpdateProfile({required this.onSuccess});
}
