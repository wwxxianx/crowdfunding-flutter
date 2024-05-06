import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  final String title;
  final Widget action;
  final EdgeInsetsGeometry padding;
  const HomePageHeader({
    super.key,
    required this.title,
    required this.action,
    this.padding = const EdgeInsets.only(
      left: Dimensions.screenHorizontalPadding,
      right: Dimensions.screenHorizontalPadding,
      top: 20.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Avatar(imageUrl: ""),
          8.kW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
          action,
        ],
      ),
    );
  }
}
