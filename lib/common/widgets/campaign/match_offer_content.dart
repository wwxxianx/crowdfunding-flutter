import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchOfferContent extends StatelessWidget {
  const MatchOfferContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBGContainer(
      startColor: Color(0xFFF1FAEA),
      endColor: Color(0xFFB7FF87),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(6),
        bottomRight: Radius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/offer-fire.svg",
                width: 18,
                height: 18,
              ),
              4.kW,
              Text(
                "Match Offer!",
                style: CustomFonts.titleSmall.copyWith(
                  color: Color(0xFF335B17),
                ),
              )
            ],
          ),
          4.kH,
          Text(
            "Your donation to this campaign, our community will donate RM1 more!",
            style: CustomFonts.labelExtraSmall.copyWith(
              color: Color(0xFF1A3E01),
            ),
          )
        ],
      ),
    );
  }
}