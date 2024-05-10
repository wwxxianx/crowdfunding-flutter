import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/custom_dropdown_menu.dart';
import 'package:crowdfunding_flutter/common/widgets/input/decorated_input_border.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrganizationVerifyPage extends StatefulWidget {
  final VoidCallback onNextPage;
  const OrganizationVerifyPage({
    super.key,
    required this.onNextPage,
  });

  @override
  State<OrganizationVerifyPage> createState() => _OrganizationVerifyPageState();
}

class _OrganizationVerifyPageState extends State<OrganizationVerifyPage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/shield-check-filled.svg",
                width: 20,
                height: 20,
              ),
              4.kW,
              const Text(
                "Verify your organization",
                style: CustomFonts.titleLarge,
              ),
            ],
          ),
          const Text(
            "The verification process might take a few minutes / hours",
            style: CustomFonts.labelSmall,
          ),
          24.kH,
          Row(
            children: [
              Expanded(
                child: CustomDropdownMenu(
                  label: "Registration type",
                  dropdownMenuEntries: List.generate(
                    4,
                    (index) => DropdownMenuEntry(
                      value: "$index",
                      label: "$index Some text",
                      enabled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          20.kH,
          Row(
            children: [
              Expanded(
                child: CustomOutlinedTextfield(
                  controller: textController,
                  label: "Registration number",
                ),
              ),
            ],
          ),
          //Form
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  style: CustomButtonStyle.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),
              ),
            ],
          ),
          8.kH,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: widget.onNextPage,
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
