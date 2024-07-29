import 'dart:ui';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/text/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SloganBanner extends StatelessWidget {
  // TIPS:
  // Use OverflowBox to crop bg image
  const SloganBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 1),
          ),
          BoxShadow(
              blurRadius: 3.0,
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 1),
              spreadRadius: 1.0),
        ],
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -15.0,
            left: -20.0,
            child: ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SvgPicture.asset("assets/images/home-banner-bg.svg"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 10.0,
              bottom: 6.0,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 185,
                      child: Text(
                        "We can’t help everyone,\nBut everyone can\nhelp someone!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    12.kH,
                    CustomButton(
                      style: CustomButtonStyle.black,
                      borderRadius: BorderRadius.circular(6.0),
                      height: 40.0,
                      onPressed: () {
                        context.go("/explore");
                      },
                      textStyle: CustomFonts.titleSmall,
                      child: const GradientText(
                        text: "Donate now!",
                        gradient: CustomColors.primaryGreenGradient,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    "assets/images/home-banner-human-donate.png",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
