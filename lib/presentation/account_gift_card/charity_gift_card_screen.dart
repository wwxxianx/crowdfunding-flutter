import 'package:crowdfunding_flutter/common/theme/app_theme.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/purchase_gift_card_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/tab_give.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/tab_receive.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiftCardScreen extends StatefulWidget {
  static const String route = "/gift-card";
  const GiftCardScreen({
    super.key,
  });

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen>
    with SingleTickerProviderStateMixin {
  late PageController pageViewController;
  @override
  void initState() {
    super.initState();
    pageViewController = PageController();
  }

  void _handleTabChanged(int tabIndex) {
    if (tabIndex == 0) {
      pageViewController.animateToPage(
        0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.decelerate,
      );
      return;
    }
    pageViewController.animateToPage(
      1,
      duration: const Duration(milliseconds: 700),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        menuTheme: MenuThemeData(
          style: MenuStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            surfaceTintColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gift Card",
            style: CustomFonts.labelMedium,
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              final giftCardState = context.watch<GiftCardBloc>().state;
              final numOfUnusedGiftCards = giftCardState.receivedGiftCards
                  .where((giftCard) => giftCard.campaignDonation == null)
                  .length;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding,
                ),
                child: CustomTab(
                  width: double.maxFinite,
                  tabs: [
                    const TabItem(title: 'Give'),
                    const TabItem(title: 'Sent'),
                    TabItem(
                      title:
                          'Received ${numOfUnusedGiftCards > 0 ? '($numOfUnusedGiftCards)' : ''}',
                    ),
                  ],
                  onTabItemChange: _handleTabChanged,
                ),
              );
            }),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageViewController,
                children: [
                  GiveTabContent(),
                  ReceivedTabContent(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
