import 'dart:io';

class CreateScamReportPayload {
  final String campaignId;
  final String description;
  final List<File> evidenceImageFiles;
  final List<File> documentFiles;

  const CreateScamReportPayload({
    required this.campaignId,
    required this.description,
    this.documentFiles = const [],
    this.evidenceImageFiles = const [],
  });
}
