import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class CommentAndReplies extends StatelessWidget {
  final void Function(CampaignComment campaignComment) onReplyButtonPressed;
  final CampaignComment comment;
  // final bool isShowingReplyButton;
  const CommentAndReplies({
    super.key,
    required this.onReplyButtonPressed,
    required this.comment,
    // required this.isShowingReplyButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Parent comment
        if (comment.parentId == null)
          CommentItem(
            // isShowingReplyButton: true,
            onReplyButtonPressed: onReplyButtonPressed,
            comment: comment,
          ),
        // Replies
        if (comment.replies.isNotEmpty) 8.kH,
        if (comment.replies.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 44),
            child: Column(
              children: [
                ...comment.replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CommentItem(
                      onReplyButtonPressed: onReplyButtonPressed,
                      comment: reply,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final void Function(CampaignComment campaignComment) onReplyButtonPressed;
  // final bool isShowingReplyButton;
  final CampaignComment comment;
  const CommentItem({
    super.key,
    // this.isShowingReplyButton = false,
    required this.onReplyButtonPressed,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Avatar(
              imageUrl: comment.user.profileImageUrl,
              placeholder: comment.user.fullName[0],
            ),
            8.kW,
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user.fullName,
                    style: CustomFonts.bodySmall.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  ),
                  Text(
                    comment.comment,
                    style: CustomFonts.labelMedium,
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      Text(
                        comment.createdAt.toCommentDate(),
                        style: CustomFonts.bodySmall.copyWith(
                          color: CustomColors.textGrey,
                        ),
                      ),
                      4.kW,
                      if (state is AppUserLoggedIn &&
                          state.user.id != comment.user.id)
                        InkWell(
                          onTap: () {
                            onReplyButtonPressed(comment);
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
            ),
          ],
        );
      },
    );
  }
}
