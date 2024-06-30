import 'dart:io';

import 'package:dio/dio.dart';

class CreateOrganizationPayload {
  final String npoName;
  // final String registrationNumber;
  final String npoEmail;
  final String npoContactPhoneNumber;
  final File? imageFile;

  const CreateOrganizationPayload({
    // required this.registrationNumber,
    required this.npoName,
    required this.npoContactPhoneNumber,
    required this.npoEmail,
    this.imageFile,
  });

  // Convert to Map for FormData.fromMap()
  Map<String, dynamic> toMap() {
    final MultipartFile? imageBytes = imageFile != null
        ? MultipartFile.fromBytes(imageFile!.readAsBytesSync())
        : null;

    // Must match with backend data structure
    return {
      // 'registrationNumber': registrationNumber,
      'name': npoName,
      'email': npoEmail,
      'contactPhoneNumber': npoContactPhoneNumber,
      'imageFile': imageBytes,
    };
  }
}

class UpdateOrganizationPayload extends CreateOrganizationPayload {
  final String organizationId;

  UpdateOrganizationPayload({
    required super.npoName,
    required super.npoContactPhoneNumber,
    required super.npoEmail,
    super.imageFile,
    required this.organizationId,
  });
}
