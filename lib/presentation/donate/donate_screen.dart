import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/money_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final donationTextController = TextEditingController();
  bool isAnonymousSelected = false;

  void _handleAnonymousChanged(bool value) {
    setState(() {
      isAnonymousSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Donate",
          style: CustomFonts.labelLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.screenHorizontalPadding,
            right: Dimensions.screenHorizontalPadding,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "You’re about to support the ",
                    style: CustomFonts.bodyMedium,
                    children: [
                      TextSpan(
                        text: "Keep LIC Safe and Clean",
                        style: CustomFonts.titleSmall,
                      ),
                      TextSpan(
                        text: " fundraiser.",
                      ),
                    ],
                  ),
                ),
                24.kH,
                const Text(
                  "Donation data",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.containerBorderGrey,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/incognito.svg"),
                                4.kW,
                                const Text(
                                  "Anonymous donation",
                                  style: CustomFonts.labelSmall,
                                )
                              ],
                            ),
                            const Text(
                              "Don’t display my name publicly on the campaign.",
                              style: CustomFonts.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 1,
                        child: Switch(
                          value: isAnonymousSelected,
                          onChanged: _handleAnonymousChanged,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFE2E8F0),
                          activeTrackColor: CustomColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),

                //Payment method
                24.kH,
                const Text(
                  "Payment method",
                  style: CustomFonts.labelMedium,
                ),
                4.kH,
                Row(
                  children: [
                    const Icon(
                      Symbols.lock_rounded,
                      size: 16,
                      color: CustomColors.textGrey,
                    ),
                    2.kW,
                    Text(
                      "Secured payment powered by Stripe",
                      style: CustomFonts.labelSmall.copyWith(
                        color: CustomColors.textGrey,
                      ),
                    ),
                  ],
                ),
                4.kH,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/mastercard.png",
                      ),
                      18.kW,
                      const Text(
                        "Mastercard",
                        style: CustomFonts.labelMedium,
                      ),
                      const Spacer(),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: CustomColors.primaryGreen,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: const HeroIcon(
                          HeroIcons.check,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Donation input
                24.kH,
                MoneyTextField(controller: donationTextController),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
                        child: const Text("Confirm"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
