import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:flutter/material.dart';

class MatchedCodeNPOPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const MatchedCodeNPOPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<MatchedCodeNPOPage> createState() => _MatchedCodeNPOPageState();
}

class _MatchedCodeNPOPageState extends State<MatchedCodeNPOPage> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPreviousPage();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Is this your NPO / Charity?",
              style: CustomFonts.titleLarge,
            ),
            12.kH,
            Text(
              "Please select your NPO / Charity",
              style: CustomFonts.labelMedium.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            8.kH,
            SelectableContainer(
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: Row(
                children: [
                  Avatar(imageUrl: ""),
                  12.kW,
                  Text(
                    "Organization name",
                    style: CustomFonts.titleMedium,
                  ),
                ],
              ),
            ),
            24.kH,
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    style: CustomButtonStyle.white,
                    onPressed: widget.onPreviousPage,
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
      ),
    );
  }
}
