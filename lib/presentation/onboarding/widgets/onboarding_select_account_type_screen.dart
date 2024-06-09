import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/dialog.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_npo_join_method_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/personal_account_page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingSelectAccountScreen extends StatefulWidget {
  static const route = '/select-account';
  // static route() => SlideRoute(page: const OnboardingSelectAccountScreen());
  const OnboardingSelectAccountScreen({super.key});

  @override
  State<OnboardingSelectAccountScreen> createState() =>
      _OnboardingSelectAccountScreenState();
}

class _OnboardingSelectAccountScreenState
    extends State<OnboardingSelectAccountScreen> {
  bool isPersonalSelected = true;

  void _handleSelectPersonal() {
    setState(() {
      isPersonalSelected = true;
    });
  }

  void _handleSelectNPO() {
    setState(() {
      isPersonalSelected = false;
    });
  }

  void _handleNextPage() {
    if (isPersonalSelected) {
      context.push(OnboardingPersonalProfileScreen.route);
    } else {
      context.push(OnboardingSelectNPOJoinMethodScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context.displayDialog(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please complete the onboarding",
                  style: CustomFonts.titleMedium,
                ),
                12.kH,
                Text(
                  "Don't worry, it only takes a few steps and requires only 2-3 minutes",
                ),
              ],
            ),
          );
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              bottom: 20,
              top: MediaQuery.of(context).viewPadding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Finish setting up your account!",
                  style: CustomFonts.titleLarge,
                ),
                20.kH,
                SelectableContainer(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 14,
                    bottom: 0,
                  ),
                  isSelected: isPersonalSelected,
                  onTap: _handleSelectPersonal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Personal",
                              style: CustomFonts.titleMedium,
                            ),
                            4.kH,
                            const Text(
                              "You can help anyone and fundraise for yourself!",
                              style: CustomFonts.labelSmall,
                            )
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/home-banner-human-donate.png",
                          width: 140,
                          height: 140,
                        ),
                      ),
                    ],
                  ),
                ),
                18.kH,
                SelectableContainer(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 14,
                    bottom: 0,
                  ),
                  isSelected: !isPersonalSelected,
                  onTap: _handleSelectNPO,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "NPO / Charity",
                              style: CustomFonts.titleMedium,
                            ),
                            4.kH,
                            const Text(
                              "Fundraise with your team and help others together!",
                              style: CustomFonts.labelSmall,
                            )
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/bank.png",
                          width: 160,
                          height: 160,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: _handleNextPage,
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
