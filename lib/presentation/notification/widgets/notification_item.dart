import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationItem extends StatelessWidget {
  final Border? border;
  final NotificationModel notification;
  const NotificationItem({
    super.key,
    required this.notification,
    this.border,
  });

  void _handlePressed(BuildContext context) {
    context
        .read<AppUserCubit>()
        .toggleReadNotification(notificationId: notification.id);
    switch (notification.typeEnum) {
      case NotificationType.COMMUNITY_CHALLENGE_REWARD:
        context.push('/community-challenges/${notification.entityId}');
        break;
      case NotificationType.CAMPAIGN_STATUS_CHANGED:
      case NotificationType.CAMPAIGN_DONATION:
      case NotificationType.CAMPAIGN_UPDATE:
      case NotificationType.NEW_MATCHED_CAMPAIGN:
        context.push(CampaignDetailsScreen.generateRoute(
            campaignId: notification.entityId));
        break;
      default:
        return;
    }
  }

  Widget _buildFooter() {
    // final notificationType = NotificationType.values.byName(notification.type);
    switch (notification.typeEnum) {
      case NotificationType.COIN:
      case NotificationType.CAMPAIGN_COMMENT:
      case NotificationType.CAMPAIGN_DONATION:
      case NotificationType.COMMUNITY_CHALLENGE_REWARD:
      case NotificationType.CAMPAIGN_STATUS_CHANGED:
        return Text(
          notification.createdAt.toTimeAgo(),
          style: CustomFonts.labelExtraSmall.copyWith(
            color: CustomColors.textGrey,
          ),
        );
      case NotificationType.CAMPAIGN_UPDATE:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Avatar(
                  imageUrl: notification.campaign?.thumbnailUrl,
                  size: 45,
                  border: Border.all(color: Colors.white),
                ),
                Positioned(
                  right: -10,
                  child: Avatar(
                    imageUrl: notification.actor?.profileImageUrl,
                    size: 26,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            16.kW,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notification.actor != null)
                  Text(
                    "Posted by ${notification.actor!.fullName}",
                    style: CustomFonts.labelExtraSmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                Text(
                  notification.createdAt.toTimeAgo(),
                  style: CustomFonts.labelExtraSmall
                      .copyWith(color: CustomColors.textGrey),
                ),
              ],
            ),
          ],
        );
      default:
        return Text('nothing');
    }
  }

  Widget _buildHeader() {
    switch (notification.typeEnum) {
      case NotificationType.CAMPAIGN_STATUS_CHANGED:
        return const SizedBox.shrink();
      case NotificationType.COIN:
        return Row(
          children: [
            SvgPicture.asset("assets/icons/coin.svg"),
            6.kW,
            Text(
              "+${notification.metadata?['coinEarned']}",
              style: CustomFonts.labelMedium,
            ),
          ],
        );
      case NotificationType.CAMPAIGN_COMMENT:
        return Row(
          children: [
            SvgPicture.asset("assets/icons/coin.svg"),
            6.kW,
            const Text(
              "New comment",
              style: CustomFonts.labelMedium,
            ),
          ],
        );
      case NotificationType.COMMUNITY_CHALLENGE_REWARD:
        return Row(
          children: [
            SvgPicture.asset("assets/icons/circus.svg"),
            6.kW,
            const Text(
              "Check out your challenge reward!",
              style: CustomFonts.labelMedium,
            ),
          ],
        );
      default:
        return const SizedBox();
    }
    // if (notificationType == NotificationType.COIN) {
    //   return Row(
    //     children: [
    //       SvgPicture.asset("assets/icons/coin.svg"),
    //       6.kW,
    //       Text(
    //         "+${notification.metadata?['coinEarned']}",
    //         style: CustomFonts.labelMedium,
    //       ),
    //     ],
    //   );
    // }
    // if (notificationType == NotificationType.CAMPAIGN_COMMENT) {
    //   return Row(
    //     children: [
    //       SvgPicture.asset("assets/icons/coin.svg"),
    //       6.kW,
    //       const Text(
    //         "New comment",
    //         style: CustomFonts.labelMedium,
    //       ),
    //     ],
    //   );
    // }

    // return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handlePressed(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
          vertical: 14.0,
        ),
        decoration: BoxDecoration(
          border: border ??
              const Border(
                bottom: BorderSide(
                  color: CustomColors.containerBorderGrey,
                ),
              ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (notification.typeEnum == NotificationType.COIN &&
                notification.typeEnum == NotificationType.CAMPAIGN_COMMENT)
              8.kH,
            Row(
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: CustomFonts.labelMedium,
                  ),
                ),
                if (!notification.isRead) 12.kW,
                if (!notification.isRead)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.accentGreen),
                  ),
              ],
            ),
            2.kH,
            if (notification.description != null &&
                notification.description!.isNotEmpty)
              Text(
                notification.description!,
                style: CustomFonts.bodySmall,
              ),
            8.kH,
            _buildFooter(),
          ],
        ),
      ),
    );
  }
}
