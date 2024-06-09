import 'dart:io';

import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class CreateNpoState extends Equatable {
  final String? registrationNumber;
  final String? registrationNumberError;
  final File? imageFile;
  final String? npoName;
  final String? npoNameError;
  final String? npoEmail;
  final String? npoEmailError;
  final String? npoPhoneNumber;
  final String? npoPhoneNumberError;
  final ApiResult<UserModel> createOrganizationResult;

  const CreateNpoState._({
    this.registrationNumber,
    this.registrationNumberError,
    this.imageFile,
    this.npoName,
    this.npoNameError,
    this.npoEmail,
    this.npoEmailError,
    this.npoPhoneNumber,
    this.npoPhoneNumberError,
    this.createOrganizationResult = const ApiResultInitial(),
  });

  const CreateNpoState.initial() : this._();

  CreateNpoState copyWith({
    String? registrationNumber,
    String? registrationNumberError,
    File? imageFile,
    String? npoName,
    String? npoNameError,
    String? npoEmail,
    String? npoEmailError,
    String? npoPhoneNumber,
    String? npoPhoneNumberError,
    ApiResult<UserModel>? createOrganizationResult,
  }) {
    return CreateNpoState._(
      registrationNumber: registrationNumber ?? this.registrationNumber,
      registrationNumberError:
          registrationNumberError ?? this.registrationNumberError,
      imageFile: imageFile ?? this.imageFile,
      npoName: npoName ?? this.npoName,
      npoNameError: npoNameError ?? this.npoNameError,
      npoEmail: npoEmail ?? this.npoEmail,
      npoEmailError: npoEmailError ?? this.npoEmailError,
      npoPhoneNumber: npoPhoneNumber ?? this.npoPhoneNumber,
      npoPhoneNumberError: npoPhoneNumberError ?? this.npoPhoneNumberError,
      createOrganizationResult: createOrganizationResult ?? this.createOrganizationResult,
    );
  }

  @override
  List<Object?> get props => [
        registrationNumber,
        registrationNumberError,
        imageFile,
        npoName,
        npoNameError,
        npoEmail,
        npoEmailError,
        npoPhoneNumber,
        npoPhoneNumberError,
        createOrganizationResult,
      ];
}
