import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/dialog.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/chat_bubble_shape.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class OpenGiftCardScreen extends StatefulWidget {
  final GiftCard? giftCard;
  final String giftCardId;
  static const String route = "/open-gift-card/:id";
  static generateRoute({required String id}) => "/open-gift-card/$id";
  const OpenGiftCardScreen({
    super.key,
    this.giftCard,
    required this.giftCardId,
  });

  @override
  State<OpenGiftCardScreen> createState() => _OpenGiftCardScreenState();
}

class _OpenGiftCardScreenState extends State<OpenGiftCardScreen> {
  late GiftCard giftCard;

  @override
  void initState() {
    super.initState();
    if (widget.giftCard != null) {
      giftCard = widget.giftCard!;
      return;
    }
    // Fetch from backend
    giftCard = GiftCard.sample;
  }

  void _handleSelectGiftCardToUse() {
    context.read<GiftCardBloc>().add(OnSelectGiftCardToUse(giftCard: giftCard));
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: const Text(
        "Use your gift card to donate!",
        style: CustomFonts.labelSmall,
      ),
      description: const Text(
        "Choose a fundraiser and donate with your gift!",
        style: CustomFonts.labelSmall,
      ),
      icon: SvgPicture.asset("assets/icons/gift.svg"),
      alignment: Alignment.topLeft,
      primaryColor: CustomColors.primaryGreen,
      autoCloseDuration: const Duration(seconds: 7),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
    context.go('/explore');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/images/opened_gift_card.svg"),
                  // Sender avatar
                  Positioned(
                    bottom: 20,
                    left: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Avatar(
                          imageUrl: giftCard.sender.profileImageUrl,
                          placeholder: giftCard.sender.fullName[0],
                          size: 26,
                        ),
                        Text(
                          giftCard.sender.fullName,
                          style: GoogleFonts.merienda(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "RM${giftCard.amount}",
                          style: GoogleFonts.merienda(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Celebration animation lottie
                  Lottie.asset("assets/animations/celebration.json",
                      repeat: true),
                  Positioned(
                    top: -52,
                    child: Container(
                      height: 219,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          width: 194,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Wish you:",
                                style: CustomFonts.bodyExtraSmall,
                              ),
                              Text(
                                giftCard.message,
                                style: CustomFonts.labelExtraSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.kH,
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                          "How to use my gift?",
                          style: CustomFonts.labelSmall
                              .copyWith(color: CustomColors.textDarkGreen),
                        ),
                      ],
                    ),
                    4.kH,
                    Text(
                      "You can use the amount in your gift to support anyone with your own choice!",
                      style: CustomFonts.bodyMedium.copyWith(
                        color: CustomColors.textDarkGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimensions.screenHorizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        size: Size(
                            250,
                            (250 * 0.2175732217573222)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: ChatBubbleShapePainter(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            print("tap");
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Don't know which one to give?",
                                style: CustomFonts.labelSmall,
                              ),
                              Text(
                                "Yes, please help me!",
                                style: CustomFonts.labelSmall.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.kW,
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      "assets/images/emoji-thinking-face.svg",
                    ),
                  ),
                ],
              ),
            ),
            20.kH,
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.screenHorizontalPadding,
                right: Dimensions.screenHorizontalPadding,
                bottom: Dimensions.screenHorizontalPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: _handleSelectGiftCardToUse,
                      child: const Text("Use my gift now!"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
