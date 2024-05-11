import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/beneficiary_form.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:flutter/material.dart';

class FundraiserMediaUploadPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const FundraiserMediaUploadPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<FundraiserMediaUploadPage> createState() =>
      _FundraiserMediaUploadPageState();
}

class _FundraiserMediaUploadPageState extends State<FundraiserMediaUploadPage> {
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
              "Upload photo for your fundraiser (5 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            ImagePicker(),
            8.kH,
            TipsButton(onPressed: () {}),
            28.kH,
            const Text(
              "Upload video for your fundraiser (Optional, 1 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            ImagePicker(),
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
                    child: const Text("Done"),
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
