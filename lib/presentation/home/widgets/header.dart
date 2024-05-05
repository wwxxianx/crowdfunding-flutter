import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.screenHorizontalPadding,
        right: Dimensions.screenHorizontalPadding,
        top: 20.0,
      ),
      child: Row(
        children: [
          Avatar(imageUrl: ""),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back!",
                style: CustomFonts.titleSmall,
              ),
              Text(
                "John Doe",
                style: CustomFonts.labelSmall
                    .copyWith(color: CustomColors.textGrey),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: Colors.black, width: 1.0),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/coin.svg",
                  height: 24.0,
                  width: 24.0,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Text(
                  "28",
                  style: CustomFonts.labelSmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
