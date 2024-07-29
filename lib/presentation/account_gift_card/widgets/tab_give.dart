import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/purchase_gift_card_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';

class GiveTabContent extends StatelessWidget {
  const GiveTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenHorizontalPadding),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/girl-holding-gift-card.svg"),
          20.kH,
          Text(
              "A gift of giving. Your recipient chooses a project to support and hears back from the fundraiser."),
          16.kH,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: CustomColors.informationContainerGreen,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/gift.svg",
                      width: 20,
                      height: 20,
                    ),
                    4.kW,
                    Text(
                      "How it works:",
                      style: CustomFonts.labelSmall
                          .copyWith(color: CustomColors.textDarkGreen),
                    ),
                  ],
                ),
                4.kH,
                Text(
                  "The gift card is a gift of giving. You purchase the gift card (it's 100% tax deductible), and your recipient gets to choose a campaign to support using the funds on the card.",
                  style: CustomFonts.bodyMedium.copyWith(
                    color: CustomColors.textDarkGreen,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Please remember that the",
                    style: CustomFonts.bodyMedium.copyWith(
                      color: CustomColors.textDarkGreen,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "recipient must own an account in order to receive your gift card.",
                        style: CustomFonts.labelMedium.copyWith(
                          color: CustomColors.textDarkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.kH,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      isDismissible: true,
                      elevation: 0,
                      context: context,
                      builder: (BuildContext context) {
                        return PurchaseGiftCardBottomSheet();
                      },
                    );
                  },
                  child: Text("Buy a gift card"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
