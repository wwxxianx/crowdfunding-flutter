import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/step_indicator.dart';
import 'package:crowdfunding_flutter/common/widgets/dropdown_menu/state_dropdown_menu.dart';
import 'package:crowdfunding_flutter/common/widgets/input/money_input.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFundraiserDetailsForm extends StatefulWidget {
  const EditFundraiserDetailsForm({super.key});

  @override
  State<EditFundraiserDetailsForm> createState() =>
      _EditFundraiserDetailsFormState();
}

class _EditFundraiserDetailsFormState extends State<EditFundraiserDetailsForm> {
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  void _handleTargetAmountChanged(targetAmount) {
    context
        .read<EditCampaignBloc>()
        .add(OnTargetAmountTextChanged(targetAmount: targetAmount));
  }

  void _handleSelectCategory(categoryId) {
    context
        .read<EditCampaignBloc>()
        .add(OnSelectCampaignCategory(categoryId: categoryId));
  }

  void _handleSelectState(stateId) {
    context.read<EditCampaignBloc>().add(OnSelectState(stateId: stateId));
  }

  void _handlePhoneNumberChanged(phoneNumber) {
    context
        .read<EditCampaignBloc>()
        .add(OnPhoneNumberChanged(phoneNumber: phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditCampaignBloc, EditCampaignState>(
      listener: (context, state) {
        if (state.isInitiatingDataFields) {
          amountTextController.text = state.targetAmountText ?? "";
          phoneTextController.text = state.phoneNumberText ?? "";
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header title
            Row(
              children: [
                StepIndicator(currentStep: "1", totalSteps: "4"),
                4.kW,
                Text(
                  "Fundraiser Details",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            12.kH,
            const Text(
              "How much would you like to raise?",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            MoneyTextField(
              errorText: state.targetAmountError,
              controller: amountTextController,
              onChanged: _handleTargetAmountChanged,
            ),
            28.kH,
            const Text(
              "What kind of fundraiser are you creating? (Select one)",
              style: CustomFonts.bodyMedium,
            ),
            if (state.categoryError != null)
              Text(
                state.categoryError!,
                style: CustomFonts.bodySmall.copyWith(color: Colors.redAccent),
              ),
            8.kH,
            CampaignCategoryList(
              onPressed: (campaignCategory) {
                _handleSelectCategory(campaignCategory.id);
              },
              selectedCategoryIds: state.selectedCategoryId != null
                  ? List.from([state.selectedCategoryId!])
                  : [],
            ),
            28.kH,
            const Text(
              "Where are you fundraising?",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            StateAndRegionsDropdownMenu(
              errorText: state.stateError,
              onSelected: _handleSelectState,
              initialSelection: state.selectedStateId,
            ),
            28.kH,
            const Text(
              "Fundraiser contact method",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              errorText: state.phoneNumberError,
              controller: phoneTextController,
              onChanged: (value) => _handlePhoneNumberChanged(value),
              label: "Phone number",
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/malaysia-flag.png"),
                    4.kW,
                    const Text(
                      "+60",
                      style: CustomFonts.labelSmall,
                    )
                  ],
                ),
              ),
              inputFormatters: [PhoneInputFormatter()],
              keyboardType: TextInputType.phone,
            ),
          ],
        );
      },
    );
  }
}
