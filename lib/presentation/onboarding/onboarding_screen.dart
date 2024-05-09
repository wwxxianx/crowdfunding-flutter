import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Finish setting up your account!",
                  style: CustomFonts.titleLarge,
                ),
                20.kH,
                InkWell(
                  onTap: _handleSelectPersonal,
                  child: Ink(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 14,
                      bottom: 14,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isPersonalSelected
                          ? CustomColors.containerLightGreen
                          : Colors.white,
                      border: Border.all(
                        color: isPersonalSelected
                            ? CustomColors.accentGreen
                            : const Color(0xFFE9E9E9),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: isPersonalSelected
                          ? [
                              const BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0, 2),
                                color: CustomColors.primaryGreen,
                              )
                            ]
                          : null,
                    ),
                    child: Opacity(
                      opacity: isPersonalSelected ? 1 : 0.6,
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
                  ),
                ),
                18.kH,
                InkWell(
                  onTap: _handleSelectNPO,
                  child: Ink(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 14,
                      bottom: 0,
                    ),
                    decoration: BoxDecoration(
                      color: !isPersonalSelected
                          ? CustomColors.containerLightGreen
                          : Colors.white,
                      border: Border.all(
                        color: !isPersonalSelected
                            ? CustomColors.accentGreen
                            : const Color(0xFFE9E9E9),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: !isPersonalSelected
                          ? [
                              const BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0, 2),
                                color: CustomColors.primaryGreen,
                              )
                            ]
                          : null,
                    ),
                    child: Opacity(
                      opacity: isPersonalSelected ? 0.6 : 1,
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
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
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
