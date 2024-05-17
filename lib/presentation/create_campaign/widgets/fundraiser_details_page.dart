
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
      builder: (context, state) {
        return Padding(
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
                controller: amountTextController,
                onChanged: (value) {
                  context
                      .read<CreateCampaignBloc>()
                      .add(OnTargetAmountTextChanged(targetAmount: value));
                },
              ),
              28.kH,
              const Text(
                "What kind of fundraiser are you creating? (Select one)",
                style: CustomFonts.bodyMedium,
              ),
              8.kH,
              CamapaignCategoryList(
                onPressed: (campaignCategory) {},
              ),
              28.kH,
              const Text(
                "Where are you fundraising?",
                style: CustomFonts.bodyMedium,
              ),
              8.kH,
              
              StateAndRegionsDropdownMenu(),
              28.kH,
              const Text(
                "Fundraiser contact method",
                style: CustomFonts.bodyMedium,
              ),
              8.kH,
              CustomOutlinedTextfield(
                controller: phoneTextController,
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
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: widget.onNextPage,
                      child: const Text("Continue"),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
