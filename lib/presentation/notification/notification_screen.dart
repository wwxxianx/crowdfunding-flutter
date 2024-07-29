import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/presentation/notification/widgets/notification_item.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  static const route = 'notification';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AppUserCubit>().fetchNotifications();
  }

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
                BlocBuilder<AppUserCubit, AppUserState>(
                  builder: (context, state) {
                    if (state.notifications.isNotEmpty) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationItem(
                            border: index == 0
                                ? const Border.symmetric(
                                    horizontal: BorderSide(
                                      color: CustomColors.containerBorderGrey,
                                    ),
                                  )
                                : null,
                            notification: state.notifications[index],
                          );
                        },
                      );
                    }
                    return Text('Empty');
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
