import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/screens/open_gift_card_screen.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SentTabContent extends StatelessWidget {
  const SentTabContent({super.key});

  Widget _buildContent(GiftCardState state) {
    final sentGiftCards = state.sentGiftCards;
    if (sentGiftCards.isNotEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sentGiftCards.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: SentGiftCardItem(
              giftCard: sentGiftCards[index],
            ),
          );
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

class SentGiftCardItem extends StatelessWidget {
  final GiftCard giftCard;
  const SentGiftCardItem({
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
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.containerBorderGrey,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                imageUrl: giftCard.receiver.profileImageUrl,
                placeholder: giftCard.receiver.fullName[0],
                size: 50,
              ),
              12.kW,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Sent a gift of RM${giftCard.amount} ",
                        style: CustomFonts.bodyMedium,
                        children: [
                          TextSpan(
                            text: giftCard.receiver.fullName,
                            style: CustomFonts.labelMedium,
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
    );
  }
}
