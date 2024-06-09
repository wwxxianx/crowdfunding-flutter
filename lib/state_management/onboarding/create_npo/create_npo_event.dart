import 'dart:io';
import 'package:flutter/material.dart';

@immutable
sealed class CreateNpoEvent {
  const CreateNpoEvent();
}

class OnRegistrationNumberChanged extends CreateNpoEvent {
  final String value;

  const OnRegistrationNumberChanged(this.value);
}

class OnNpoNameChanged extends CreateNpoEvent {
  final String value;

  const OnNpoNameChanged(this.value);
}

class OnEmailChanged extends CreateNpoEvent {
  final String value;

  const OnEmailChanged(this.value);
}

class OnPhoneNumberChanged extends CreateNpoEvent {
  final String value;

  const OnPhoneNumberChanged(this.value);
}

class OnImageFileChanged extends CreateNpoEvent {
  final File imageFile;

  const OnImageFileChanged(this.imageFile);
}

class OnCreateOrganization extends CreateNpoEvent {
  final VoidCallback onSuccess;

  const OnCreateOrganization({required this.onSuccess});
}
