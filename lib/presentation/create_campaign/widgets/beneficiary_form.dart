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
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryForm extends StatefulWidget {
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  const BeneficiaryForm({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<BeneficiaryForm> createState() => _BeneficiaryFormState();
}

class _BeneficiaryFormState extends State<BeneficiaryForm> {
  final amountController = TextEditingController();
  AgeGroup selectedAge = AgeGroup.baby;

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
                  "Who are you fundraising for?",
                  style: CustomFonts.bodyMedium,
                ),
                8.kH,
                CustomOutlinedTextfield(
                  controller: amountController,
                  label: "Full name",
                ),
                28.kH,
                const Text(
                  "Upload photo for your fundraiser’s beneficiary (Optional, 1 maximum)",
                  style: CustomFonts.bodyMedium,
                ),
                12.kH,
                const MediaPicker(),
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
                        // onPressed: widget.onPreviousPage,
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
                        onPressed: widget.onNextPage,
                        child: const Text("Continue"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
