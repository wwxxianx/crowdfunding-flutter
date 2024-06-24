import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizationCampaignsTabContent extends StatelessWidget {
  const OrganizationCampaignsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Give your help to the community',
          style: CustomFonts.labelMedium,
        ),
        12.kH,
        SizedBox(
          width: double.maxFinite,
          child: CustomButton(
            onPressed: () {
              context.push('/explore-collaborations');
            },
            child: Text(
              "Let's help",
            ),
          ),
        ),
      ],
    );
  }
}
