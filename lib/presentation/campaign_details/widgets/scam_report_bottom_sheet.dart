import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/file_picker.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScamReportBottomSheet extends StatelessWidget {
  const ScamReportBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          footer: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding, vertical: 14),
              child: CustomButton(
                isLoading: state.createScamReportResult is ApiResultLoading,
                enabled: state.createScamReportResult is! ApiResultLoading,
                onPressed: () {
                  context.read<CampaignDetailsBloc>().add(OnCreateScamReport(
                    onSuccess: () {
                      context.pop();
                    },
                  ));
                },
                child: const Text('Submit Report'),
              ),
            ),
          ),
          initialChildSize: 0.95,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scam Report',
                  style: CustomFonts.titleMedium,
                ),
                20.kH,
                CustomOutlinedTextfield(
                  label: "Report Description",
                  onChanged: (value) {
                    context
                        .read<CampaignDetailsBloc>()
                        .add(OnScamReportDescriptionChanged(value: value));
                  },
                  maxLines: 4,
                ),
                12.kH,
                const Text(
                  'Attachments',
                  style: CustomFonts.labelMedium,
                ),
                8.kH,
                const Text(
                  'Please provide any image or document that can help to support your report',
                  style: CustomFonts.bodySmall,
                ),
                8.kH,
                MediaPicker(
                  limit: 5,
                  onSelected: (files) {
                    context
                        .read<CampaignDetailsBloc>()
                        .add(OnScamReportImageFilesChanged(imageFiles: files));
                  },
                ),
                8.kH,
                CustomFilePicker(
                  limit: 5,
                  onSelected: (files) {
                    context.read<CampaignDetailsBloc>().add(
                        OnScamReportDocumentFilesChanged(documentFiles: files));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
