import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/step_indicator.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFundraiserDescriptionForm extends StatefulWidget {
  const EditFundraiserDescriptionForm({super.key});

  @override
  State<EditFundraiserDescriptionForm> createState() =>
      _EditFundraiserDescriptionFormState();
}

class _EditFundraiserDescriptionFormState
    extends State<EditFundraiserDescriptionForm> {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  void _handleTitleChanged(title) {
    context.read<EditCampaignBloc>().add(OnTitleChanged(title: title));
  }

  void _handleDescriptionChanged(description) {
    context
        .read<EditCampaignBloc>()
        .add(OnDescriptionChanged(description: description));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditCampaignBloc, EditCampaignState>(
      listener: (context, state) {
        if (state.isInitiatingDataFields) {
          titleTextController.text = state.titleText ?? "";
          descriptionTextController.text = state.descriptionText ?? "";
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StepIndicator(currentStep: "3", totalSteps: "4"),
                4.kW,
                Text(
                  "Fundraiser Description",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            const Text(
              "Give your fundraiser a title",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              errorText: state.titleError,
              label: "Title",
              controller: titleTextController,
              onChanged: _handleTitleChanged,
            ),
            8.kH,
            TipsButton(onPressed: () {}),
            28.kH,
            const Text(
              "Let others know more about your fundraiser",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              errorText: state.descriptionError,
              onChanged: _handleDescriptionChanged,
              controller: descriptionTextController,
              label: "Content",
              maxLines: 10,
              hintText: "Hello, I’m Ellisa and would like to...",
            ),
          ],
        );
      },
    );
  }
}
