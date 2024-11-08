import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/screens/open_gift_card_screen.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReceivedTabContent extends StatelessWidget {
  const ReceivedTabContent({super.key});

  Widget _buildContent(GiftCardState state) {
    final receivedGiftCards = state.receivedGiftCards;
    if (receivedGiftCards.isNotEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: receivedGiftCards.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ReceivedGiftCardItem(giftCard: receivedGiftCards[index]));
        },
      );
    }
    // Empty
    return Text("Empty");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardBloc, GiftCardState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<GiftCardBloc>()
                .add(OnFetchAllGiftCards(isRefresh: true));
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 20,
              ),
              child: _buildContent(state),
            ),
          ),
        );
      },
    );
  }
}

class ReceivedGiftCardItem extends StatelessWidget {
  final GiftCard giftCard;
  const ReceivedGiftCardItem({
    super.key,
    required this.giftCard,
  });

  void _navigateToOpenCardScreen(BuildContext context) {
    context.push(OpenGiftCardScreen.generateRoute(id: giftCard.id),
        extra: giftCard);
  }

  Widget _buildActionButton(BuildContext context) {
    if (giftCard.campaignDonation != null) {
      // Already used
      return CustomButton(
        style: CustomButtonStyle.grey,
        borderRadius: BorderRadius.circular(4),
        height: 34,
        onPressed: null,
        child: const Text(
          "Already used",
          style: CustomFonts.labelSmall,
        ),
      );
    }
    return CustomButton(
      borderRadius: BorderRadius.circular(4),
      height: 34,
      onPressed: () {
        _navigateToOpenCardScreen(context);
      },
      child: const Text(
        "Receive my gift",
        style: CustomFonts.labelSmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.textBlack,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Avatar(
                      imageUrl: giftCard.sender.profileImageUrl,
                      placeholder: giftCard.sender.fullName[0],
                      size: 50,
                    ),
                    12.kW,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: giftCard.sender.fullName,
                              style: CustomFonts.labelMedium,
                              children: [
                                TextSpan(
                                  text:
                                      " sent you a gift of RM${giftCard.amount}!",
                                  style: CustomFonts.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          2.kH,
                          Text(giftCard.message, style: CustomFonts.bodySmall),
                          4.kH,
                          Text(
                            giftCard.createdAt.toTimeAgo(),
                            style: CustomFonts.labelExtraSmall.copyWith(
                              color: CustomColors.textGrey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                12.kH,
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (giftCard.campaignDonation != null) 0.kH,
          if (giftCard.campaignDonation != null)
            AnimatedBGContainer(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              startColor: const Color(0xFFF1FAEA),
              endColor: const Color(0xFFB7FF87),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: CustomColors.textBlack),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: giftCard.campaignDonation!.campaign != null
                            ? giftCard.campaignDonation!.campaign!.thumbnailUrl
                            : "null",
                        errorWidget: (context, url, error) {
                          return const CircularProgressIndicator();
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  8.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Donated to:",
                        style: CustomFonts.labelExtraSmall,
                      ),
                      Text(
                        giftCard.campaignDonation!.campaign != null
                            ? giftCard.campaignDonation!.campaign!.title
                            : "Unknown",
                        style: CustomFonts.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
