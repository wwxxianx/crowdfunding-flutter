import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/presentation/notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';

class NotificationScreen extends StatelessWidget {
  static const route = '/notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.screenHorizontalPadding,
                  ),
                  child: Text(
                    "Notification",
                    style: CustomFonts.titleLarge,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: NotificationModel.samples.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      border: index == 0
                          ? const Border.symmetric(
                              horizontal: BorderSide(
                                color: CustomColors.containerBorderGrey,
                              ),
                            )
                          : null,
                      notification: NotificationModel.samples[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
