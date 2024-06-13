import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/chat_bubble_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: CardSwiper(
              cardsCount: 4,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Text('$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
