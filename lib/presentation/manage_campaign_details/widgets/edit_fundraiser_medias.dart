import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/step_indicator.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFundraiserMediasForm extends StatefulWidget {
  const EditFundraiserMediasForm({super.key});

  @override
  State<EditFundraiserMediasForm> createState() =>
      _EditFundraiserMediasFormState();
}

class _EditFundraiserMediasFormState extends State<EditFundraiserMediasForm> {
  void _handleRemoveImage(ImageModel image) {
    context.read<EditCampaignBloc>().add(OnRemoveImage(image: image));
  }

  void _handleCampaignImageFilesChanged(List<File> files) {
    context
        .read<EditCampaignBloc>()
        .add(OnCampaignImageFilesChanged(imageFiles: files));
  }

  void _handleCampaignVideoFileChanged(List<File> files) {
    context
        .read<EditCampaignBloc>()
        .add(OnCampaignVideoFileChanged(videoFile: files[0]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCampaignBloc, EditCampaignState>(
      builder: (context, state) {
        final campaignResult = state.campaignResult;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StepIndicator(currentStep: "4", totalSteps: "4"),
                4.kW,
                Text(
                  "Fundraiser Medias",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            const Text(
              "Upload photo for your fundraiser (5 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            MediaPicker(
              previewImageModels: campaignResult is ApiResultSuccess<Campaign>
                  ? campaignResult.data.images
                  : [],
              onRemovePreviewImageModel: _handleRemoveImage,
              limit: 5,
              onSelected: _handleCampaignImageFilesChanged,
            ),
            8.kH,
            TipsButton(onPressed: () {
              if (campaignResult is ApiResultSuccess<Campaign>) {
                print(campaignResult.data.images.length);
              }
            }),
            28.kH,
            const Text(
              "Upload video for your fundraiser (Optional, 1 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            MediaPicker(
              isVideo: true,
              onSelected: _handleCampaignVideoFileChanged,
            ),
          ],
        );
      },
    );
  }
}
