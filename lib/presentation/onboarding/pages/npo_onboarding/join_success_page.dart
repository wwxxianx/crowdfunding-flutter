import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class JoinSuccessPage extends StatelessWidget {
  const JoinSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              20.kH,
              Avatar(
                imageUrl: "",
                size: 130,
              ),
              18.kH,
              Text(
                "You’re now a part of Bill Gates Fuondation!",
                style: CustomFonts.labelLarge,
                textAlign: TextAlign.center,
              ),
              8.kH,
              Text(
                "Let’s help the world with your team!",
                style: CustomFonts.labelLarge,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        context.go(HomeScreen.route);
                      },
                      child: const Text("OK"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Lottie.asset("assets/animations/celebration.json"),
        ],
      ),
    );
  }
}
