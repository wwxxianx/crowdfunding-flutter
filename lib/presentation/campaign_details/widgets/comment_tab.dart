import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignCommentTabContent extends StatelessWidget {
  // Pass the comment id for reference in bloc
  final void Function(String commentID) onReplyButtonPressed;
  const CampaignCommentTabContent({
    super.key,
    required this.onReplyButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          CommentList(
            onReplyButtonPressed: onReplyButtonPressed,
          ),
          CommentList(
            onReplyButtonPressed: onReplyButtonPressed,
          ),
        ],
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final void Function(String commentID) onReplyButtonPressed;
  const CommentList({
    super.key,
    required this.onReplyButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentItem(
          isShowingCommentButton: true,
          onReplyButtonPressed: onReplyButtonPressed,
        ),
        8.kH,
        Container(
          margin: const EdgeInsets.only(left: 44),
          child: Column(
            children: [
              ...List.generate(2, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: CommentItem(
                    onReplyButtonPressed: onReplyButtonPressed,
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final void Function(String commentID) onReplyButtonPressed;
  final bool isShowingCommentButton;
  const CommentItem({
    super.key,
    this.isShowingCommentButton = false,
    required this.onReplyButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Avatar(imageUrl: ""),
        8.kW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Elissa",
              style: CustomFonts.bodySmall.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            const Text(
              "How about the funds?",
              style: CustomFonts.labelMedium,
            ),
            Row(
              children: [
                Text(
                  "May 12",
                  style: CustomFonts.bodySmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
                if (isShowingCommentButton) 4.kW,
                if (isShowingCommentButton)
                  InkWell(
                    onTap: () {
                      onReplyButtonPressed("0");
                    },
                    child: Row(
                      children: [
                        Text(
                          "Reply",
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.textGrey,
                          ),
                        ),
                        2.kW,
                        const Icon(
                          Symbols.reply_rounded,
                          size: 16,
                          color: CustomColors.textGrey,
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
