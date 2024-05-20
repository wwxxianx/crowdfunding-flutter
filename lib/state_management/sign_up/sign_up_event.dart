import 'package:flutter/material.dart';

sealed class SignUpEvent {}

final class OnSignUp extends SignUpEvent {
  final String email;
  final String password;
  final VoidCallback onSuccess;
  OnSignUp({
    required this.email,
    required this.password,
    required this.onSuccess,
  });
}

final class OnSignOut extends SignUpEvent {}

final class CheckLoggedIn extends SignUpEvent {}
