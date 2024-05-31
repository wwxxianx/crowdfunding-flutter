import 'dart:ui';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/presentation/donate/donate_screen.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CampaignDetailsBottomSheet extends StatefulWidget {
  final String campaignId;
  final FocusNode commentFieldFocusNode;
  const CampaignDetailsBottomSheet({
    super.key,
    required this.campaignId,
    required this.commentFieldFocusNode,
  });

  @override
  State<CampaignDetailsBottomSheet> createState() =>
      _CampaignDetailsBottomSheetState();
}

class _CampaignDetailsBottomSheetState
    extends State<CampaignDetailsBottomSheet> {
  final commentTextController = TextEditingController();

  void _navigateToDonateScreen() {
    context.push(DonateScreen.generateRoute(campaignId: widget.campaignId));
  }

  void _handleOpenCommentBottomBar(BuildContext context) {
    context.read<CampaignDetailsBloc>()
      ..add(const OnTabIndexChanged(2))
      ..add(const OnToggleCommentBottomBar(isShow: true));
    widget.commentFieldFocusNode.requestFocus();
  }

  void _handleHideCommentBottomBar(BuildContext context) {
    context.read<CampaignDetailsBloc>()
      ..add(OnClearSelectedCommentToReply())
      ..add(const OnToggleCommentBottomBar(isShow: false));
  }

  void _handleCommentSubmit(BuildContext context) {
    final bloc = context.read<CampaignDetailsBloc>();
    final selectedCommentToReply = bloc.state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      // Reply
      final payload = CreateCampaignReplyPayload(
        campaignId: widget.campaignId,
        parentId: selectedCommentToReply.parentId ?? selectedCommentToReply.id,
        comment: commentTextController.text,
      );
      bloc.add(OnSubmitReply(payload));
    } else {
      // New comment (parent)
      final payload = CreateCampaignCommentPayload(
        campaignId: widget.campaignId,
        comment: commentTextController.text,
      );
      bloc.add(OnSubmitComment(payload));
    }
    _handleHideCommentBottomBar(context);
    commentTextController.clear();
  }

  Widget _buildReplyBottomSheetTitle(CampaignDetailsState state) {
    final selectedCommentToReply = state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "Reply to: @${selectedCommentToReply.user.fullName} “${selectedCommentToReply.comment}”",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.kH,
        ],
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 14.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReplyBottomSheetTitle(state),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: state.isShowingCommentBottomBar
                            ? CustomOutlinedTextfield(
                                controller: commentTextController,
                                focusNode: widget.commentFieldFocusNode,
                                textInputAction: TextInputAction.send,
                                onFieldSubmitted: (value) {
                                  _handleCommentSubmit(context);
                                },
                              )
                            : CustomButton(
                                style: CustomButtonStyle.gradientGreen,
                                onPressed: _navigateToDonateScreen,
                                child: const Text("Donate"),
                              ),
                      ),
                      8.kW,
                      state.isShowingCommentBottomBar
                          ? CustomIconButton(
                              onPressed: () {
                                _handleHideCommentBottomBar(context);
                              },
                              icon: const HeroIcon(HeroIcons.xMark),
                            )
                          : CustomIconButton(
                              onPressed: () {
                                _handleOpenCommentBottomBar(context);
                              },
                              icon: const HeroIcon(
                                  HeroIcons.chatBubbleLeftEllipsis),
                            ),
                      state.isShowingCommentBottomBar
                          ? CustomIconButton(
                              isLoading: state.createCommentResult
                                      is ApiResultLoading ||
                                  state.createReplyResult is ApiResultLoading,
                              enabled: state.createCommentResult
                                      is! ApiResultLoading &&
                                  state.createReplyResult is! ApiResultLoading,
                              onPressed: () {
                                _handleCommentSubmit(context);
                              },
                              icon: const HeroIcon(HeroIcons.paperAirplane),
                            )
                          : CustomIconButton(
                              onPressed: () {},
                              icon: const HeroIcon(HeroIcons.share),
                            )
                    ],
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final giftCardState = context.watch<GiftCardBloc>().state;
                if (giftCardState.selectedGiftCardToUse == null) {
                  return const SizedBox();
                }
                return Positioned(
                  top: -80,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width -
                            (Dimensions.screenHorizontalPadding * 2)),
                    color: Colors.white.withOpacity(0.6),
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.screenHorizontalPadding,
                      vertical: 16,
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            "You can use the gift (RM500) received from Kelvin Tan to support this fundraiser.",
                            style: CustomFonts.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
