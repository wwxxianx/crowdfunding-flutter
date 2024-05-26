import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItem extends StatelessWidget {
  final Border? border;
  final NotificationModel notification;
  const NotificationItem({
    super.key,
    required this.notification,
    this.border,
  });

  Widget _buildFooter() {
    switch (notification.type) {
      case NotificationType.coin:
      case NotificationType.campaignComment:
      case NotificationType.campaignDonation:
        return Text(
          notification.createdAt.toTimeAgo(),
          style: CustomFonts.labelExtraSmall.copyWith(
            color: CustomColors.textGrey,
          ),
        );
      case NotificationType.campaignUpdate:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Avatar(
                  imageUrl: notification.campaignImageUrl,
                  size: 45,
                  border: Border.all(color: Colors.white),
                ),
                Positioned(
                  right: -10,
                  child: Avatar(
                    imageUrl: notification.actorImageUrl,
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
    }
  }

  Widget _buildHeader() {
    if (notification.type == NotificationType.coin) {
      return Row(
        children: [
          SvgPicture.asset("assets/icons/coin.svg"),
          6.kW,
          Text(
            "+${notification.coinEarned}",
            style: CustomFonts.labelMedium,
          ),
        ],
      );
    }
    if (notification.type == NotificationType.campaignComment) {
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
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (notification.type == NotificationType.coin &&
              notification.type == NotificationType.campaignComment)
            8.kH,
          Text(
            notification.title,
            style: CustomFonts.labelMedium,
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
    );
  }
}
