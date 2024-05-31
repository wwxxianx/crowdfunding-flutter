import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/money_input.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_bloc.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_event.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_state.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class DonateScreen extends StatefulWidget {
  final String? campaignTitle;
  final String campaignId;
  static const route = '/donate/:campaignId';
  static generateRoute({required String campaignId}) => '/donate/$campaignId';
  const DonateScreen({
    super.key,
    required this.campaignId,
    required this.campaignTitle,
  });

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

  void _handleCreateDonation(BuildContext context) {
    final selectedGiftCardToUse =
        context.read<GiftCardBloc>().state.selectedGiftCardToUse;
    context.read<DonateBloc>().add(OnCreateDonation(
        amount: selectedGiftCardToUse != null
            ? selectedGiftCardToUse.amount
            : int.parse(donationTextController.text),
        campaignId: widget.campaignId,
        isAnonymous: isAnonymousSelected,
        giftCardId: selectedGiftCardToUse?.id,
        onSuccess: () {
          // context.push("location");
        }));
  }

  Widget _buildStripePaymentMethodContent() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildGiftCardDonationContent() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.accentGreen),
            color: CustomColors.containerLightGreen,
            boxShadow: CustomColors.containerGreenShadow,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/gift.svg"),
                  4.kW,
                  Text(
                    "Gift Card Donation",
                    style: CustomFonts.labelMedium,
                  ),
                ],
              ),
              4.kH,
              Text(
                "You’re using the gift (RM500) received from Kelvin Tan to support this campaign.",
                style: CustomFonts.bodySmall,
              ),
            ],
          ),
        ),
        Positioned(
          right: -10,
          top: -10,
          child: GestureDetector(
            onTap: () {
              context.read<GiftCardBloc>().add(OnRemoveSelectedGiftCard());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Color(0xFFFEFEFE)),
                boxShadow: CustomColors.cardShadow,
              ),
              padding: const EdgeInsets.all(4.0),
              child: const HeroIcon(
                HeroIcons.xMark,
                style: HeroIconStyle.mini,
                color: Color(0xFFAEAEAE),
                size: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonateBloc(paymentService: serviceLocator()),
      child: BlocBuilder<DonateBloc, DonateState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Donate",
                style: CustomFonts.labelLarge,
              ),
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.screenHorizontalPadding,
                            right: Dimensions.screenHorizontalPadding,
                            bottom: 20,
                          ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/incognito.svg"),
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
                                        inactiveTrackColor:
                                            const Color(0xFFE2E8F0),
                                        activeTrackColor:
                                            CustomColors.primaryGreen,
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
                              Builder(builder: (context) {
                                final giftCardBloc =
                                    context.watch<GiftCardBloc>();
                                return AnimatedCrossFade(
                                  firstChild: _buildGiftCardDonationContent(),
                                  secondChild:
                                      _buildStripePaymentMethodContent(),
                                  crossFadeState: giftCardBloc
                                              .state.selectedGiftCardToUse !=
                                          null
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 500),
                                  layoutBuilder: (topChild, topChildKey,
                                      bottomChild, bottomChildKey) {
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        topChild,
                                        bottomChild,
                                      ],
                                    );
                                  },
                                );
                              }),

                              // Donation input
                              24.kH,
                              Builder(builder: (context) {
                                final selectedGiftCardToUse = context
                                    .watch<GiftCardBloc>()
                                    .state
                                    .selectedGiftCardToUse;
                                return MoneyTextField(
                                  readOnly: selectedGiftCardToUse != null,
                                  controller: selectedGiftCardToUse == null
                                      ? donationTextController
                                      : null,
                                  initialValue: selectedGiftCardToUse != null
                                      ? selectedGiftCardToUse.amount.toString()
                                      : null,
                                );
                              }),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      isLoading: state.isCreatingDonation,
                                      onPressed: () {
                                        _handleCreateDonation(context);
                                      },
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
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
