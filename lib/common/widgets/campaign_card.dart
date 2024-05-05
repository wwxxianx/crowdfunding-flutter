import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/tag/custom_tag.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth > 393
        ? 343
        : deviceWidth - (Dimensions.screenHorizontalPadding * 2);

    return Container(
      width: cardWidth,
      height: 395.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      "https://i.ibb.co/Ss74GM1/joel-muniz-A4-Ax1-Apccf-A-unsplash.jpg",
                  height: 246.0,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.0,
                left: 12.0,
                child: CustomTag(
                  prefixIcon: HeroIcon(
                    HeroIcons.mapPin,
                    size: 16.0,
                    color: Color(0xFF2F2F2F),
                  ),
                  label: "Kuala Lumpur",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2023/09/27 (2 months ago)",
                          style: CustomFonts.labelExtraSmall
                              .copyWith(color: CustomColors.textGrey),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            CampaignCategoryTag(
                              isSmall: true,
                            ),
                            CustomTag(
                              label: "65% Raised",
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: HeroIcon(
                        HeroIcons.heart,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Campaign Title",
                  style: CustomFonts.titleMedium,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DonationProgressBar(
                  total: 10.0,
                  current: 7.5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CampaignCategoryTag extends StatelessWidget {
  final bool isSmall;
  const CampaignCategoryTag({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =
        isSmall ? CustomFonts.labelExtraSmall : CustomFonts.labelMedium;

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.only(
          left: isSmall ? 8.0 : 10.0,
          right: isSmall ? 10.0 : 12.0,
          top: isSmall ? 6.0 : 8,
          bottom: isSmall ? 6.0 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xFFFFF1F2),
        ),
        child: Row(
          children: [
            Icon(
              Symbols.ecg_heart,
              size: isSmall ? 16.0 : 20.0,
              color: Color(0xFF9F1239),
            ),
            const SizedBox(width: 4.0),
            Text(
              "Medical",
              style: textStyle.copyWith(
                color: Color(0xFF9F1239),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DonationProgressBar extends StatelessWidget {
  final double total;
  final double current;
  final double height;
  const DonationProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.height = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / total);
    String formattedTotal = NumberFormat('#,###').format(total);
    String formattedCurrent = NumberFormat('#,###').format(current);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            children: [
              Text(
                "RM ${formattedCurrent} / RM ${formattedTotal}",
                style: CustomFonts.labelExtraSmall,
              ),
              Text(
                " (800 donations)",
                style: CustomFonts.titleExtraSmall,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFF2F1F1),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  gradient: CustomColors.primaryGreenGradient,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
