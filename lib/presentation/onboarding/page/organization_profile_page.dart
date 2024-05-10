import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrganizationProfilePage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const OrganizationProfilePage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<OrganizationProfilePage> createState() => _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
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
            Row(
              children: [
                SvgPicture.asset("assets/icons/organization-filled.svg"),
                4.kW,
                const Text(
                  "Finish setting up your NPO",
                  style: CustomFonts.titleLarge,
                ),
              ],
            ),
            const Text(
              "The information provided should correctly reflect your NPO.",
              style: CustomFonts.labelSmall,
            ),
            24.kH,
            //Form
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
