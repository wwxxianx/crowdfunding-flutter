import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CampaignCommentTabContent extends StatelessWidget {
  // Pass the comment id for reference in bloc
  final void Function(CampaignComment campaignComment) onReplyButtonPressed;
  final List<CampaignComment> comments;
  const CampaignCommentTabContent({
    super.key,
    required this.onReplyButtonPressed,
    required this.comments,
  });

  Widget _buildContent() {
    if (comments.isEmpty) {
      // Empty
      return const EmptyComment();
    }
    return Column(
      children: [
        ...comments.map((comment) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: CommentAndReplies(
                onReplyButtonPressed: onReplyButtonPressed, comment: comment),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: 16.0,
      ),
      child: _buildContent(),
    );
  }
}

class EmptyComment extends StatelessWidget {
  const EmptyComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/icons/message-emoji-filled-big.svg"),
        12.kH,
        const Text(
          "There's no comment for this campaign",
          style: CustomFonts.labelMedium,
        ),
        // 12.kH,
        // CustomButton(
        //   style: CustomButtonStyle.black,
        //   onPressed: () {},
        //   child: const Text(
        //     "Leave first comment",
        //   ),
        // ),
      ],
    );
  }
}
