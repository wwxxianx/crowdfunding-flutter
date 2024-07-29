import 'package:crowdfunding_flutter/common/theme/app_theme.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/tab_give.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/tab_receive.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/tab_sent.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftCardScreen extends StatelessWidget {
  static const String route = "/gift-card";
  const GiftCardScreen({
    super.key,
  });

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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Gift Card",
              style: CustomFonts.labelMedium,
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color(0xFFF1F9F2),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 3.0,
                          offset: const Offset(0, 1),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 2.0,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    labelColor: CustomColors.textBlack,
                    unselectedLabelColor: Colors.black54,
                    tabs: [
                      const TabItem(title: 'Give'),
                      const TabItem(title: 'Sent'),
                      Builder(builder: (context) {
                        final giftCardState =
                            context.watch<GiftCardBloc>().state;
                        final numOfUnusedGiftCards = giftCardState
                            .receivedGiftCards
                            .where(
                                (giftCard) => giftCard.campaignDonation == null)
                            .length;
                        return TabItem(
                          title:
                              'Received ${numOfUnusedGiftCards > 0 ? '($numOfUnusedGiftCards)' : ''}',
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              GiveTabContent(),
              SentTabContent(),
              ReceivedTabContent(),
            ],
          ),
        ),
      ),
    );
  }
}
