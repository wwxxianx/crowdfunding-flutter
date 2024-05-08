import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ManageCampaignScreen extends StatelessWidget {
  const ManageCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: CustomColors.primaryGreen,
        shape: const CircleBorder(),
        onPressed: () {},
        child: HeroIcon(HeroIcons.plus),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.screenHorizontalPadding,
            right: Dimensions.screenHorizontalPadding,
            top: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your fundraisers",
                style: CustomFonts.titleMedium,
              ),
              CampaignCard(),
            ],
          ),
        ),
      ),
    );
  }
}
