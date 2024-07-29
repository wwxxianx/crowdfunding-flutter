import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/data/network/response/create_organization_response.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class JoinNPOSuccessScreen extends StatefulWidget {
  final Organization? organizationInfo;
  final String organizationId;
  static const route = '/onboarding-join-npo-success/:organizationId';
  static generateRoute({required String organizationId}) =>
      "/onboarding-join-npo-success/$organizationId";
  const JoinNPOSuccessScreen({
    required this.organizationId,
    super.key,
    this.organizationInfo,
  });

  @override
  State<JoinNPOSuccessScreen> createState() => _JoinNPOSuccessScreenState();
}

class _JoinNPOSuccessScreenState extends State<JoinNPOSuccessScreen> {
  late Organization organization;

  @override
  void initState() {
    super.initState();
    if (widget.organizationInfo != null) {
      // Fetch again from backend
      organization = widget.organizationInfo!;
      return;
    }
    organization = Organization.samples.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
          right: Dimensions.screenHorizontalPadding,
          bottom: Dimensions.screenHorizontalPadding,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                160.kH,
                Avatar(
                  imageUrl: organization.imageUrl,
                  placeholder: organization.name[0],
                  size: 130,
                ),
                18.kH,
                Text(
                  "You’re now a part of ${organization.name}!",
                  style: CustomFonts.labelLarge,
                  textAlign: TextAlign.center,
                ),
                8.kH,
                const Text(
                  "Let’s help the world with your team!",
                  style: CustomFonts.labelLarge,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          context.go("/home");
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
      ),
    );
  }
}
