import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/slide_route_transition.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/enter_code_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/join_success_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/matched_code_npo_page.dart';
import 'package:flutter/material.dart';

class JoinWithCodePageView extends StatefulWidget {
  static route() => SlideRoute(page: const JoinWithCodePageView());
  // final VoidCallback onPreviousPage;
  const JoinWithCodePageView({
    super.key,
    // required this.onPreviousPage,
  });

  @override
  State<JoinWithCodePageView> createState() => _JoinWithCodePageViewState();
}

class _JoinWithCodePageViewState extends State<JoinWithCodePageView> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handlePageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _handleNextPage() {
    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  void _handlePreviousPage() {
    setState(() {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pregress bar
              OnboardingProgressBar(
                currentStep: currentPage,
                totalStep: 3,
              ),
              24.kH,
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _handlePageChange,
                  children: [
                    EnterCodePage(
                      onNextPage: _handleNextPage,
                      // onPreviousPage: widget.onPreviousPage,
                    ),
                    MatchedCodeNPOPage(
                      onNextPage: _handleNextPage,
                      onPreviousPage: _handlePreviousPage,
                    ),
                    JoinSuccessPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalStep;
  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      child: Row(
        children: [
          ...List.generate(
            totalStep,
            (index) => Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    margin: index != totalStep - 1
                        ? EdgeInsets.only(right: 8)
                        : null,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Color.fromARGB(255, 224, 224, 224),
                    ),
                  ),
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 500),
                    widthFactor: currentStep >= index ? 1 : 0,
                    child: Container(
                      margin: index != totalStep - 1
                          ? EdgeInsets.only(right: 8)
                          : null,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF9DFF9D),
                          Color(0xFFE6FF82),
                        ]),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
