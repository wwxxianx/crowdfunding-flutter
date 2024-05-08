import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampaignUpdateTabContent extends StatelessWidget {
  const CampaignUpdateTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: Dimensions.screenHorizontalPadding,
      ),
      child: Column(
        children: [...List.generate(1, (index) => CampaignUpdateItem())],
      ),
    );
  }
}

class CampaignUpdateItem extends StatelessWidget {
  const CampaignUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageCarouselWithNumberIndicator(),
        8.kH,
        Text(
          "2023/09/27 - 08:00",
          style: CustomFonts.bodySmall.copyWith(color: CustomColors.textGrey),
        ),
        4.kH,
        Text(
          "Travelling as a way of self-discovery and progress",
          style: CustomFonts.labelMedium,
        ),
        4.kH,
        ExpandableText(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
          maxLines: 3,
        ),
      ],
    );
  }
}

class ImageCarouselWithNumberIndicator extends StatefulWidget {
  const ImageCarouselWithNumberIndicator({super.key});

  @override
  State<ImageCarouselWithNumberIndicator> createState() =>
      _ImageCarouselWithNumberIndicatorState();
}

class _ImageCarouselWithNumberIndicatorState
    extends State<ImageCarouselWithNumberIndicator> {
  late PageController _pageViewController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<String> images = [
    "assets/images/campaign-image-sample.jpg",
    "assets/images/campaign-image-sample-2.jpg",
    "assets/images/campaign-image-sample.jpg",
    "assets/images/campaign-image-sample-2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: 1.25 / 1,
            child: PageView.builder(
              controller: _pageViewController,
              onPageChanged: _handlePageChange,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  // borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 48,
                margin: const EdgeInsets.only(
                  top: 6,
                  right: 6,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black.withOpacity(0.3),
                  border: Border.all(
                    color: const Color(0xFFD2CFCF),
                    width: 1,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: '${_currentPage + 1}',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' / ${images.length}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Color(0xFFD2CFCF),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
