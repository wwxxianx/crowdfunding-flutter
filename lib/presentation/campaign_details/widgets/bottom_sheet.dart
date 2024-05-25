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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Navigator.push(context, DonateScreen.route());
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
        return Container(
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
                          icon:
                              const HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
                        ),
                  state.isShowingCommentBottomBar
                      ? CustomIconButton(
                          isLoading:
                              state.createCommentResult is ApiResultLoading ||
                                  state.createReplyResult is ApiResultLoading,
                          enabled:
                              state.createCommentResult is! ApiResultLoading &&
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
        );
      },
    );
  }
}
