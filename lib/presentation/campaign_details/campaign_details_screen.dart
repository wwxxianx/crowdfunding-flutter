import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/image_carousel.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/protect_info_banner.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CampaignDetailsScreen extends StatelessWidget {
  const CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton.filledTonal(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.white.withOpacity(0.87),
            ),
          ),
          onPressed: () {},
          icon: const HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.black,
            size: 18.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCarousel(),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Campaign Title",
                  style: CustomFonts.titleLarge,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DonationProgressBar(
                  current: 3799,
                  total: 10000,
                  height: 12.0,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CampaignCategoryTag(),
                const SizedBox(
                  height: 12.0,
                ),
                ProtectInfoBanner(),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          DefaultTabController(
            length: 4,
            child: TabBar(
              labelPadding:
                  EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
              tabs: [
                Text(
                  "About",
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "Donations",
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "Updates",
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
