import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';

class EnterCodePage extends StatefulWidget {
  final VoidCallback onNextPage;
  const EnterCodePage({
    super.key,
    required this.onNextPage,
  });

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  final codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your NPO invitation code",
            style: CustomFonts.titleLarge,
          ),
          24.kH,
          CustomOutlinedTextfield(
            controller: codeTextController,
            hintText: "2k3Jz98",
            label: "Invitation code",
          ),
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
