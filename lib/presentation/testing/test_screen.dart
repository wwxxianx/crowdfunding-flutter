import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/chat_bubble_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(
                      250,
                      (250 * 0.2175732217573222)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: ChatBubbleShapePainter(),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 6, left: 6),
                  child: GestureDetector(
                    onTap: () {
                      print("tap");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Don't know which one to give?",
                          style: CustomFonts.labelSmall,
                        ),
                        Text(
                          "Yes, please help me!",
                          style: CustomFonts.labelSmall.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            4.kW,
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SvgPicture.asset(
                "assets/images/emoji-thinking-face.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
