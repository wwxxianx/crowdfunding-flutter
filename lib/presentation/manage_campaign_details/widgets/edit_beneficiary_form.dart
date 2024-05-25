import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/step_indicator.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBeneficiaryForm extends StatefulWidget {
  const EditBeneficiaryForm({super.key});

  @override
  State<EditBeneficiaryForm> createState() => _EditBeneficiaryFormState();
}

class _EditBeneficiaryFormState extends State<EditBeneficiaryForm> {
  final TextEditingController beneficiaryNameTextController =
      TextEditingController();

   void _handleBeneficiaryNameChanged(name) {
    context
        .read<EditCampaignBloc>()
        .add(OnBeneficiaryNameChanged(beneficiaryName: name));
  }

  void _handleBeneficiaryFileChanged(File file) {
    context
        .read<EditCampaignBloc>()
        .add(OnBeneficiaryImageFileChanged(imageFile: file));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditCampaignBloc, EditCampaignState>(
      listener: (context, state) {
        if (state.isInitiatingDataFields) {
          beneficiaryNameTextController.text = state.beneficiaryNameText ?? "";
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StepIndicator(currentStep: "2", totalSteps: "4"),
                4.kW,
                Text(
                  "Beneficiary Information",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            const Text(
              "Who are you fundraising for?",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              errorText: state.beneficiaryNameError,
              controller: beneficiaryNameTextController,
              label: "Full name",
              onChanged: _handleBeneficiaryNameChanged,
            ),
            28.kH,
            const Text(
              "Upload photo for your fundraiser’s beneficiary (Optional, 1 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            12.kH,
            MediaPicker(
              preview: state.beneficiaryImageFile != null
                  ? [state.beneficiaryImageFile!]
                  : null,
              onSelected: (files) {
                _handleBeneficiaryFileChanged(files[0]);
              },
            ),
            28.kH,
            const Text(
              "Your beneficiary age?",
              style: CustomFonts.bodyMedium,
            ),
            12.kH,
            // Wrap(
            //   direction: Axis.horizontal,
            //   spacing: 8,
            //   runSpacing: 8,
            //   children: [
            //     ...AgeGroup.values.map(
            //       (age) => SelectableContainer(
            //         isSelected: selectedAge == age,
            //         onTap: () {
            //           setState(() {
            //             selectedAge = age;
            //           });
            //         },
            //         child: Text(
            //           "${age.getAgeText()} (${age.getAgeTitle()})",
            //           style: CustomFonts.labelSmall.copyWith(
            //             color: selectedAge == age
            //                 ? CustomColors.accentGreen
            //                 : CustomColors.textGrey,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        );
      },
    );
  }
}
