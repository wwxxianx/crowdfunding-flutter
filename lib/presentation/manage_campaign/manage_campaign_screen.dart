import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/create_campaign_screen.dart';
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
        onPressed: () {
          Navigator.push(context, CreateCampaignScreen.route());
        },
        child: const HeroIcon(HeroIcons.plus),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
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
