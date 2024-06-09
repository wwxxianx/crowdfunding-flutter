import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/chat_bubble_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            onPressed: () {
              context.push('/test2');
            },
            child: Text("Go 2"),
          ),
        ],
      ),
    );
  }
}

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Screen 2'),
          CustomButton(
            onPressed: () {
              showModalBottomSheet(
                elevation: 0,
                // isScrollControlled: true,
                isDismissible: true,
                context: context,
                builder: (context) {
                  return CustomDraggableSheet(
                    initialChildSize: 0.95,
                    child: Column(
                      children: [],
                    ),
                  );
                },
              );
            },
            child: Text("Open"),
          ),
        ],
      ),
    );
  }
}
