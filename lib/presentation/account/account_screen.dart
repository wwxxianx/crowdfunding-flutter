import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/text/text_bg_gradient_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            children: [
              // Avatar header
              20.kH,
              Row(
                children: [
                  Avatar(
                    imageUrl: "",
                    size: 64,
                  ),
                  8.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Leonardo",
                            style: CustomFonts.labelLarge,
                          ),
                          4.kW,
                          HeroIcon(
                            HeroIcons.checkBadge,
                            size: 20,
                            color: CustomColors.accentGreen,
                            style: HeroIconStyle.solid,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Edit my account",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              24.kH,
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWithGradientBGShape(
                      text: Text(
                        "My Team",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 80,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/building.svg"),
                      title: Text(
                        "Bill Gate Foundation",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    )
                  ],
                ),
              ),
              20.kH,
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWithGradientBGShape(
                      text: Text(
                        "My Activity",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 90,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/hand-money.svg"),
                      title: Text(
                        "My Donations",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    ),
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/hearts.svg"),
                      title: Text(
                        "Saved",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    )
                  ],
                ),
              ),
              20.kH,
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWithGradientBGShape(
                      text: Text(
                        "For You",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 56,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/bag-coin.svg"),
                      title: Text(
                        "Rewards",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/bill-list.svg"),
                      title: Text(
                        "Tax Deduction Receipt",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    )
                  ],
                ),
              ),
              20.kH,
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWithGradientBGShape(
                      text: Text(
                        "My Account",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 90,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {},
                      leading: SvgPicture.asset("assets/icons/smile-heart.svg"),
                      title: Text(
                        "My Donations",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  const CustomListTile({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Container(
          padding: padding,
          child: Row(
            children: [
              if (leading != null) leading!,
              if (leading != null) 8.kW,
              if (title != null) title!,
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(
      left: 16.0,
      right: 12.0,
      top: 18.0,
      bottom: 12.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFF5F5F5),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              offset: Offset(0, 1),
              color: Colors.black.withOpacity(0.08),
            ),
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(0, 1),
              color: Colors.black.withOpacity(0.12),
            ),
          ]),
      child: child,
    );
  }
}
