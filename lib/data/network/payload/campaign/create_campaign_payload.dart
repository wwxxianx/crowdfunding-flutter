import 'dart:io';

import 'package:dio/dio.dart';

class CreateCampaignPayload {
  final String title;
  final String description;
  final int targetAmount;
  final String categoryId;
  final String phoneNumber;
  final String stateId;
  final String beneficiaryName;
  final List<File> campaignImageFiles;
  final File? campaignVideoFile;
  final File? beneficiaryImageFile;

  CreateCampaignPayload({
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.categoryId,
    required this.phoneNumber,
    required this.stateId,
    required this.beneficiaryName,
    required this.campaignImageFiles,
    this.campaignVideoFile,
    this.beneficiaryImageFile,
  });

  // Convert to Map for FormData.fromMap()
  Map<String, dynamic> toMap() {
    final MultipartFile? campaignVideoBytes = campaignVideoFile != null
        ? MultipartFile.fromBytes(campaignVideoFile!.readAsBytesSync())
        : null;
    final MultipartFile? beneficiaryImageBytes = beneficiaryImageFile != null
        ? MultipartFile.fromBytes(beneficiaryImageFile!.readAsBytesSync())
        : null;
    final List<MultipartFile> campaignImagesBytes =
        campaignImageFiles.map((file) => MultipartFile.fromBytes(file.readAsBytesSync())).toList();

    // Must match with backend data structure
    return {
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'categoryId': categoryId,
      'contactPhoneNumber': phoneNumber,
      'stateId': stateId,
      'beneficiaryName': beneficiaryName,
      'campaignImages': campaignImagesBytes,
      'campaignVideo': campaignVideoBytes,
      'beneficiaryImage': beneficiaryImageBytes,
    };
  }
}