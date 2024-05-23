import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchOfferTag extends StatelessWidget {
  const MatchOfferTag({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBGContainer(
      startColor: const Color(0xFFF1FAEA),
      endColor: const Color(0xFFB7FF87),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      borderRadius: BorderRadius.circular(100),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/offer-fire.svg",
            width: 16,
            height: 16,
          ),
          4.kW,
          Text(
            "Match",
            style: CustomFonts.labelExtraSmall.copyWith(
              color: const Color(0xFF335B17),
            ),
          )
        ],
      ),
    );
  }
}