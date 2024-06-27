import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/file_picker.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/common/widgets/text/expandable_text.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/scam_report_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignAboutTabContent extends StatelessWidget {
  const CampaignAboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        final campaignResult = state.campaignResult;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Organizer
              Row(
                children: [
                  SvgPicture.asset("assets/icons/organization-filled.svg"),
                  6.kW,
                  const Text(
                    "Organizer",
                    style: CustomFonts.titleMedium,
                  ),
                ],
              ),
              12.kH,
              Row(
                children: [
                  if (campaignResult is ApiResultLoading)
                    const Skeleton(
                      width: 40,
                      height: 40,
                      radius: 100,
                    ),
                  if (campaignResult is ApiResultSuccess<Campaign>)
                    Avatar(
                      imageUrl: campaignResult.data.user.profileImageUrl,
                      placeholder: campaignResult.data.user.email[0],
                    ),
                  8.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "California Agency",
                            style: CustomFonts.labelMedium,
                          ),
                          4.kW,
                          const HeroIcon(
                            HeroIcons.checkBadge,
                            size: 20.0,
                            style: HeroIconStyle.solid,
                          ),
                        ],
                      ),
                      Text(
                        "California, USA",
                        style: CustomFonts.bodySmall.copyWith(
                          color: CustomColors.textGrey,
                        ),
                      )
                    ],
                  )
                ],
              ),

              28.kH,
              // Beneficiary
              Row(
                children: [
                  const Icon(
                    Symbols.diversity_1_rounded,
                    weight: 600,
                  ),
                  6.kW,
                  const Text(
                    "Beneficiary",
                    style: CustomFonts.titleMedium,
                  ),
                ],
              ),
              12.kH,
              Row(
                children: [
                  if (campaignResult is ApiResultLoading)
                    const Skeleton(
                      width: 40,
                      height: 40,
                      radius: 100,
                    ),
                  if (campaignResult is ApiResultSuccess<Campaign>)
                    Avatar(
                      imageUrl: campaignResult.data.beneficiaryImageUrl,
                      placeholder: campaignResult.data.beneficiaryName[0],
                    ),
                  8.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (campaignResult is ApiResultLoading)
                        Skeleton(
                          width: 40,
                          height: Dimensions.loadingBodyHeight,
                        ),
                      if (campaignResult is ApiResultSuccess<Campaign>)
                        Text(
                          campaignResult.data.beneficiaryName,
                          style: CustomFonts.labelMedium,
                        ),
                      Text(
                        "California, USA",
                        style: CustomFonts.bodySmall.copyWith(
                          color: CustomColors.textGrey,
                        ),
                      )
                    ],
                  )
                ],
              ),

              28.kH,
              // Description
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About this campaign",
                  style: CustomFonts.titleMedium,
                ),
              ),
              8.kH,
              if (campaignResult is ApiResultLoading)
                Column(
                  children: List.generate(
                      5,
                      (index) => const Skeleton(
                            width: double.maxFinite,
                            height: Dimensions.loadingBodyHeight,
                            margin: EdgeInsets.only(bottom: 8),
                          )),
                ),
              if (campaignResult is ApiResultSuccess<Campaign>)
                ExpandableText(
                  text: campaignResult.data.description,
                  maxLines: 5,
                ),
              20.kH,
              // Scam Report
              ScamReportContent(),
            ],
          ),
        );
      },
    );
  }
}

class ScamReportContent extends StatelessWidget {
  const ScamReportContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.containerBorderSlate),
        boxShadow: CustomColors.containerSlateShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HeroIcon(
                HeroIcons.shieldExclamation,
                size: 20,
                color: CustomColors.textBlack,
              ),
              6.kW,
              const Text(
                'Scam Report',
                style: CustomFonts.labelMedium,
              ),
            ],
          ),
          8.kH,
          Text(
            'Feeling this campaign is a scam? Don’t feel hesitate to reach out us. Our community team will verify based on your provided evidence.',
            style: CustomFonts.bodySmall,
          ),
          8.kH,
          SizedBox(
            width: double.maxFinite,
            child: CustomButton(
              height: 40,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: CustomColors.alert),
              backgroundColor: CustomColors.alert.withOpacity(0.1),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  elevation: 0,
                  context: context,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: BlocProvider.of<CampaignDetailsBloc>(context),
                      child: ScamReportBottomSheet(),
                    );
                  },
                );
              },
              child: Text(
                'Report this campaign',
                style:
                    CustomFonts.titleSmall.copyWith(color: CustomColors.alert),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
