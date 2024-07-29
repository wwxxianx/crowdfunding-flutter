import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/donation_tab.dart';
import 'package:flutter/material.dart';

class DonationsBottomSheet extends StatelessWidget {
  final Campaign campaign;
  const DonationsBottomSheet({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.9,
      child: ListView.builder(
        padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
        shrinkWrap: true,
        itemCount: campaign.donations.length,
        itemBuilder: (context, index) {
          return DonationItem(donation: campaign.donations[index]);
        },
      ),
    );
  }
}
