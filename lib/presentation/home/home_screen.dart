import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/text/gradient_text.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/slogan_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crowdfunding_flutter/common/widgets/container/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _focusNode = FocusNode();
  bool showText = false;
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          HomePageHeader(
            title: "Welcome back!",
            action: InkWell(
              onTap: () {
                context.displayDialog(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/product-shopping-illustration.svg",
                      ),
                      20.kH,
                      const Text(
                        "Earn from your every donations and get something you want!",
                        style: CustomFonts.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      20.kH,
                      CustomButton(
                        style: CustomButtonStyle.black,
                        onPressed: () {},
                        child: const GradientText(
                          text: "Shop Now!",
                        ),
                      )
                    ],
                  ),
                );
              },
              child: Container(
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
                    2.kW,
                    Text(
                      "28",
                      style: CustomFonts.labelSmall,
                    )
                  ],
                ),
              ),
            ),
          ),
          SloganBanner(),
          CampaignCard(),
        ],
      ),
    );
  }
}
