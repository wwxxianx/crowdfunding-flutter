import 'package:flutter/material.dart';

sealed class SignUpEvent {}

final class OnSignUp extends SignUpEvent {
  final String email;
  final String password;
  final VoidCallback navigateToOnboarding;
  OnSignUp({
    required this.email,
    required this.password,
    required this.navigateToOnboarding,
  });
}

final class OnSignOut extends SignUpEvent {}

final class CheckLoggedIn extends SignUpEvent {}
