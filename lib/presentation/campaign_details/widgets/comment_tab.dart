import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignCommentTabContent extends StatelessWidget {
  const CampaignCommentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          CommentList(),
          CommentList(),
        ],
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentItem(
          isShowingCommentButton: true,
        ),
        8.kH,
        Container(
          margin: EdgeInsets.only(left: 44),
          child: Column(
            children: [
              ...List.generate(2, (index) {
                return Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: CommentItem(),
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
  final bool isShowingCommentButton;
  const CommentItem({
    super.key,
    this.isShowingCommentButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(imageUrl: ""),
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
            Text(
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
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "Reply",
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.textGrey,
                          ),
                        ),
                        2.kW,
                        Icon(
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
