import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.screenHorizontalPadding,
                  ),
                  child: Text(
                    "Notification",
                    style: CustomFonts.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationType notificationType;
  const NotificationItem({
    super.key,
    required this.notificationType,
  });

  Widget _buildFooter() {
    switch (notificationType) {
      case NotificationType.campaignUpdate:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                const Avatar(
                  imageUrl: "",
                  size: 45,
                ),
                Positioned(
                  right: -10,
                  child: Avatar(
                    imageUrl: "",
                    size: 30,
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
                Text(
                  "Posted by Mr.Jin",
                  style: CustomFonts.labelExtraSmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
                Text(
                  "2 days ago",
                  style: CustomFonts.labelExtraSmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        );
      default:
        return Text(
          "2 days ago",
          style: CustomFonts.labelExtraSmall.copyWith(
            color: CustomColors.textGrey,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.containerBorderGrey,
        ),
      ),
      child: Column(
        children: [
          if (notificationType == NotificationType.coin)
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/coin.svg",
                ),
                6.kW,
                const Text(
                  "+24",
                  style: CustomFonts.labelMedium,
                ),
              ],
            ),
          RichText(
            text: const TextSpan(
              text: "An update for ",
              style: CustomFonts.bodyMedium,
              children: [
                TextSpan(
                  text: "Helping my students to get books!",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
          ),
          8.kH,
          _buildFooter(),
        ],
      ),
    );
  }
}
