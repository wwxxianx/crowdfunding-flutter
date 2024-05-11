import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/custom_dropdown_menu.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
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
          CustomOutlinedTextfield(
            controller: amountTextController,
            prefixIcon: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "RM",
                  style: CustomFonts.labelMedium,
                ),
              ],
            ),
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
          CustomDropdownMenu(
            dropdownMenuEntries: List.generate(
              20,
              (index) =>
                  const DropdownMenuEntry(value: "index", label: "index"),
            ),
          ),
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
  }
}
