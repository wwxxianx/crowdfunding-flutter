import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_list_tile.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_card.dart';
import 'package:crowdfunding_flutter/common/widgets/text/text_bg_gradient_shape.dart';
import 'package:crowdfunding_flutter/presentation/account/screens/saved_campaigns_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _handleSignOut(BuildContext context) {
    context.read<AppUserCubit>().signOut(onSuccess: () {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      onTap: () {
                        context.push(SavedCampaignsScreen.route);
                      },
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
              24.kH,
              CustomButton(
                style: CustomButtonStyle.white,
                onPressed: () {
                  _handleSignOut(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeroIcon(
                      HeroIcons.arrowLeftOnRectangle,
                      size: 16,
                      style: HeroIconStyle.mini,
                    ),
                    4.kW,
                    Text(
                      "Sign out",
                      style: CustomFonts.labelSmall,
                    ),
                  ],
                ),
              ),
              20.kH,
            ],
          ),
        ),
      ),
    );
  }
}
