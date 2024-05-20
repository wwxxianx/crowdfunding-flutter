import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserMediaUploadPage extends StatefulWidget {
  final VoidCallback onPreviousPage;
  const FundraiserMediaUploadPage({
    super.key,
    required this.onPreviousPage,
  });

  @override
  State<FundraiserMediaUploadPage> createState() =>
      _FundraiserMediaUploadPageState();
}

class _FundraiserMediaUploadPageState extends State<FundraiserMediaUploadPage> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  void _handleCampaignImageFilesChanged(List<File> files) {
    context
        .read<CreateCampaignBloc>()
        .add(OnCampaignImageFilesChanged(imageFiles: files));
  }

  void _handleCampaignVideoFileChanged(List<File> files) {
    context
        .read<CreateCampaignBloc>()
        .add(OnCampaignVideoFileChanged(videoFile: files[0]));
  }

  void _onCreateCampaign() {
    context.read<CreateCampaignBloc>().add(OnCreateCampaign(onSuccess: () {
      // Navigate to success screen
      print('Success');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            widget.onPreviousPage();
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload photo for your fundraiser (5 maximum)",
                  style: CustomFonts.bodyMedium,
                ),
                8.kH,
                MediaPicker(
                  preview: state.campaignImageFiles,
                  limit: 5,
                  onSelected: _handleCampaignImageFilesChanged,
                ),
                8.kH,
                TipsButton(onPressed: () {}),
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
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        style: CustomButtonStyle.white,
                        onPressed: widget.onPreviousPage,
                        child: const Text("Back"),
                      ),
                    )
                  ],
                ),
                8.kH,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        isLoading: state.isCreatingCampaign,
                        enabled: !state.isCreatingCampaign,
                        onPressed: _onCreateCampaign,
                        child: const Text("Done"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
