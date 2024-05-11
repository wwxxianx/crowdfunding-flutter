import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:flutter/material.dart';

class FundraiserDescriptionFormPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const FundraiserDescriptionFormPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<FundraiserDescriptionFormPage> createState() =>
      _FundraiserDescriptionFormPageState();
}

class _FundraiserDescriptionFormPageState
    extends State<FundraiserDescriptionFormPage> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              "Give your fundraiser a title",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              label: "Title",
              controller: titleTextController,
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
              controller: descriptionTextController,
              label: "Content",
              maxLines: 10,
              hintText: "Hello, I’m Ellisa and would like to...",
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
                    onPressed: widget.onNextPage,
                    child: const Text("Continue"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
