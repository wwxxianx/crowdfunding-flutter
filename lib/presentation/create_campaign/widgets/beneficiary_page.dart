import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/domain/model/age_group.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryFormPage extends StatefulWidget {
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  const BeneficiaryFormPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<BeneficiaryFormPage> createState() => _BeneficiaryFormPageState();
}

class _BeneficiaryFormPageState extends State<BeneficiaryFormPage> {
  final beneficiaryNameTextController = TextEditingController();
  AgeGroup selectedAge = AgeGroup.baby;

  @override
  void initState() {
    super.initState();
    final beneficiaryNameText =
        context.read<CreateCampaignBloc>().state.beneficiaryNameText;
    if (beneficiaryNameText != null) {
      beneficiaryNameTextController.text = beneficiaryNameText;
    }
  }

  void _handleBeneficiaryNameChanged(name) {
    context
        .read<CreateCampaignBloc>()
        .add(OnBeneficiaryNameChanged(beneficiaryName: name));
  }

  void _handleBeneficiaryFileChanged(File file) {
    context
        .read<CreateCampaignBloc>()
        .add(OnBeneficiaryImageFileChanged(imageFile: file));
  }

  void _navigateToNextPage() {
    context.read<CreateCampaignBloc>().add(ValidateStepTwo(
      onSuccess: () {
        widget.onNextPage();
      },
    ));
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
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...AgeGroup.values.map(
                              (age) => SelectableContainer(
                                isSelected: selectedAge == age,
                                onTap: () {
                                  setState(() {
                                    selectedAge = age;
                                  });
                                },
                                child: Text(
                                  "${age.getAgeText()} (${age.getAgeTitle()})",
                                  style: CustomFonts.labelSmall.copyWith(
                                    color: selectedAge == age
                                        ? CustomColors.accentGreen
                                        : CustomColors.textGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                onPressed: _navigateToNextPage,
                                child: const Text("Continue"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
