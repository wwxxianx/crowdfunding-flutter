import 'package:crowdfunding_flutter/common/theme/app_theme.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/reward_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:google_fonts/google_fonts.dart';

class CollaborateWithNPOScreen extends StatelessWidget {
  static const route = '/collaborate-with-npo';
  const CollaborateWithNPOScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Collaborate",
          style: CustomFonts.labelMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
          right: Dimensions.screenHorizontalPadding,
          bottom: Dimensions.screenHorizontalPadding,
        ),
        child: Column(
          children: [
            // Info header
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CustomColors.containerBorderGrey),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/smile-emoji.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                  4.kW,
                  const Flexible(
                    child: Text(
                      "Don’t know how to manage your fundraiser and reach to more donors? Our community can help you!",
                      style: CustomFonts.bodyExtraSmall,
                    ),
                  ),
                ],
              ),
            ),
            24.kH,
            Text(
              "How it works?",
              style: CustomFonts.titleMedium,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.containerBorderGrey),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/collaboration.svg'),
                  20.kH,
                  Text(
                    "The team will share the responsibilities of organizing and managing your fundraiser.",
                    textAlign: TextAlign.center,
                    style: CustomFonts.labelMedium,
                  ),
                  8.kH,
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/check-circle.svg'),
                      4.kW,
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: '3x ',
                            style: GoogleFonts.inter(
                                fontSize: 14, color: CustomColors.textBlack),
                            children: [
                              TextSpan(
                                text: 'your campaign performance',
                                style: CustomFonts.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/check-circle.svg'),
                      4.kW,
                      const Flexible(
                        child: Text(
                          'Share your campaign to reach to more donors',
                          style: CustomFonts.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/check-circle.svg'),
                      4.kW,
                      const Flexible(
                        child: Text(
                          'Help to post campaign update to engage donors',
                          style: CustomFonts.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/check-circle.svg'),
                      4.kW,
                      const Flexible(
                        child: Text(
                          'Manage your campaign data to make it more better',
                          style: CustomFonts.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return RewardBottomSheet();
                        },
                      );
                    },
                    child: const Text("Send my help request"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
