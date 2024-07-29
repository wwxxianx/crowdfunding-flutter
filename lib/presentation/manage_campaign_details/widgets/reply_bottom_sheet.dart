import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class ReplyBottomSheet extends StatefulWidget {
  final String campaignId;
  final VoidCallback onClose;
  final FocusNode focusNode;
  const ReplyBottomSheet({
    super.key,
    required this.onClose,
    required this.focusNode,
    required this.campaignId,
  });

  @override
  State<ReplyBottomSheet> createState() => _ReplyBottomSheetState();
}

class _ReplyBottomSheetState extends State<ReplyBottomSheet> {
  final replyTextController = TextEditingController();

  void _handleCommentSubmit(BuildContext context) {
    final bloc = context.read<CampaignDetailsBloc>();
    final selectedCommentToReply = bloc.state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      // Reply
      final payload = CreateCampaignReplyPayload(
        campaignId: widget.campaignId,
        parentId: selectedCommentToReply.parentId ?? selectedCommentToReply.id,
        comment: replyTextController.text,
      );
      bloc.add(OnSubmitReply(
          payload: payload,
          onSuccess: () {
            widget.onClose();
            replyTextController.clear();
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: ScaffoldMask(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 14.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
                builder: (context, state) {
                  final selectedCommentToReply = state.selectedCommentToReply;
                  return Text(
                    "Reply to: @${selectedCommentToReply?.user.fullName} “${selectedCommentToReply?.comment}”",
                    style: CustomFonts.bodyMedium.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  );
                },
              ),
              4.kH,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomOutlinedTextfield(
                      controller: replyTextController,
                      focusNode: widget.focusNode,
                    ),
                  ),
                  8.kW,
                  BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
                    builder: (context, state) {
                      return CustomIconButton(
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
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
