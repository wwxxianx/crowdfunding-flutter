import 'dart:io';

class UpdateCampaignFundraiserPaylaod {
  final String campaignId;
  final String? idNumber;
  final File? signatureFile;

  UpdateCampaignFundraiserPaylaod({
    required this.campaignId,
    this.idNumber,
    this.signatureFile,
  });
  
}
