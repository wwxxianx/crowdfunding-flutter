import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:crowdfunding_flutter/common/widgets/tag/custom_tag.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

class MatchOfferTag extends StatelessWidget {
  const MatchOfferTag({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBGContainer(
      startColor: const Color(0xFFF1FAEA),
      endColor: const Color(0xFFB7FF87),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      borderRadius: BorderRadius.circular(100),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/offer-fire.svg",
            width: 16,
            height: 16,
          ),
          4.kW,
          Text(
            "Match",
            style: CustomFonts.labelExtraSmall.copyWith(
              color: const Color(0xFF335B17),
            ),
          )
        ],
      ),
    );
  }
}

class MatchOfferContent extends StatelessWidget {
  const MatchOfferContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBGContainer(
      startColor: Color(0xFFF1FAEA),
      endColor: Color(0xFFB7FF87),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(6),
        bottomRight: Radius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/offer-fire.svg",
                width: 18,
                height: 18,
              ),
              4.kW,
              Text(
                "Match Offer!",
                style: CustomFonts.titleSmall.copyWith(
                  color: Color(0xFF335B17),
                ),
              )
            ],
          ),
          4.kH,
          Text(
            "Your donation to this campaign, our community will donate RM1 more!",
            style: CustomFonts.labelExtraSmall.copyWith(
              color: Color(0xFF1A3E01),
            ),
          )
        ],
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isSmall;
  final VoidCallback? onPressed;
  const CampaignCard({
    this.campaign = Campaign.sample,
    super.key,
    this.isSmall = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth > 393
        ? 343
        : deviceWidth - (Dimensions.screenHorizontalPadding * 2);

    return IntrinsicHeight(
      child: Ink(
        width: isSmall ? null : cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.40 / 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: campaign.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (!isSmall)
                    Positioned(
                      top: 8.0,
                      left: 12.0,
                      child: CustomTag(
                        prefixIcon: HeroIcon(
                          HeroIcons.mapPin,
                          size: 16.0,
                          color: Color(0xFF2F2F2F),
                        ),
                        label: campaign.stateAndRegion.name,
                      ),
                    ),
                ],
              ),
              8.kH,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 8.0 : 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isSmall)
                                Text(
                                  "${campaign.createdAt.toISODate()} (${campaign.createdAt.toTimeAgo()})",
                                  style: CustomFonts.labelExtraSmall
                                      .copyWith(color: CustomColors.textGrey),
                                ),
                              if (!isSmall) 8.kH,
                              Row(
                                children: [
                                  CampaignCategoryTag(
                                    isSmall: true,
                                  ),
                                  if (!isSmall)
                                    CustomTag(
                                      label: "65% Raised",
                                    ),
                                  if (isSmall) MatchOfferTag(),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          if (!isSmall)
                            IconButton(
                              onPressed: () {},
                              icon: HeroIcon(
                                HeroIcons.heart,
                                size: 24.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                    6.kH,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 8.0 : 12.0),
                      child: Text(
                        campaign.title,
                        style: isSmall ? null : CustomFonts.titleMedium,
                      ),
                    ),
                    16.kH,
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: isSmall ? 8.0 : 12.0,
                        right: isSmall ? 8.0 : 12.0,
                        bottom: isSmall ? 8.0 : 0.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DonationProgressBar(
                            total: 10.0,
                            current: 7.5,
                            height: isSmall ? 8 : 10,
                            showDonationStatusText: !isSmall,
                          ),
                        ],
                      ),
                    ),
                    if (!isSmall) 12.kH,
                    // Top border for Match Offer container
                    if (!isSmall)
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        color: Colors.black,
                      ),
                    if (!isSmall) MatchOfferContent()
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

class DonationProgressBar extends StatelessWidget {
  final double total;
  final double current;
  final double height;
  final bool showDonationStatusText;
  const DonationProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.height = 10.0,
    this.showDonationStatusText = true,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / total);
    String formattedTotal = NumberFormat('#,###').format(total);
    String formattedCurrent = NumberFormat('#,###').format(current);

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "RM ${formattedCurrent} / RM ${formattedTotal}",
                style: CustomFonts.labelExtraSmall,
              ),
              if (showDonationStatusText)
                Text(
                  " (800 donations)",
                  style: CustomFonts.titleExtraSmall,
                ),
            ],
          ),
        ),
        2.kH,
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
