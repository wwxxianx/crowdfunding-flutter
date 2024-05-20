import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/dropdown_menu/state_dropdown_menu.dart';
import 'package:crowdfunding_flutter/common/widgets/input/money_input.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserDetailsFormPage extends StatefulWidget {
  final VoidCallback onNextPage;
  const FundraiserDetailsFormPage({
    super.key,
    required this.onNextPage,
  });

  @override
  State<FundraiserDetailsFormPage> createState() =>
      _FundraiserDetailsFormPageState();
}

class _FundraiserDetailsFormPageState extends State<FundraiserDetailsFormPage> {
  final amountTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final targetAmount =
        context.read<CreateCampaignBloc>().state.targetAmountText;
    if (targetAmount != null) {
      amountTextController.text = targetAmount;
    }
    final phoneNumber =
        context.read<CreateCampaignBloc>().state.phoneNumberText;
    if (phoneNumber != null) {
      phoneTextController.text = phoneNumber;
    }
  }

  void _handleTargetAmountChanged(targetAmount) {
    context
        .read<CreateCampaignBloc>()
        .add(OnTargetAmountTextChanged(targetAmount: targetAmount));
  }

  void _handleSelectCategory(categoryId) {
    context
        .read<CreateCampaignBloc>()
        .add(OnSelectCampaignCategory(categoryId: categoryId));
  }

  void _handleSelectState(stateId) {
    context.read<CreateCampaignBloc>().add(OnSelectState(stateId: stateId));
  }

  void _handlePhoneNumberChanged(phoneNumber) {
    context
        .read<CreateCampaignBloc>()
        .add(OnPhoneNumberChanged(phoneNumber: phoneNumber));
  }

  void _navigateToNextPage() {
    context.read<CreateCampaignBloc>().add(ValidateStepOne(
      onSuccess: () {
        widget.onNextPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
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
                            style: CustomFonts.bodySmall
                                .copyWith(color: Colors.redAccent),
                          ),
                        8.kH,
                        CampaignCategoryList(
                          onPressed: (campaignCategory) {
                            _handleSelectCategory(campaignCategory.id);
                          },
                          selectedCategoryIds:
                              List.from([state.selectedCategoryId]),
                        ),
                        28.kH,
                        const Text(
                          "Where are you fundraising?",
                          style: CustomFonts.bodyMedium,
                        ),
                        8.kH,
                        StateAndRegionsDropdownMenu(
                          errorText: state.stateError,
                          onSelected: (stateId) => _handleSelectState(stateId),
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
                          onChanged: (value) =>
                              _handlePhoneNumberChanged(value),
                          label: "Phone number",
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 8.0),
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
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: _navigateToNextPage,
                                child: const Text("Continue"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
