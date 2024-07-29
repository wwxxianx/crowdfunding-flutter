import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/campaign_update_recommendation_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update_recommendation.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AICampaignUpdateBottomSheet extends StatefulWidget {
  final String campaignId;
  final void Function(CampaignUpdateRecommendation result) onPopulateResult;
  const AICampaignUpdateBottomSheet({
    super.key,
    required this.campaignId,
    required this.onPopulateResult,
  });

  @override
  State<AICampaignUpdateBottomSheet> createState() =>
      _AICampaignUpdateBottomSheetState();
}

class _AICampaignUpdateBottomSheetState
    extends State<AICampaignUpdateBottomSheet>
    with SingleTickerProviderStateMixin {
  final PageController pageViewController = PageController();

  void _navigateToNextPage() {
    pageViewController.nextPage(
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.65,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) /
              100 *
              60,
        ),
        child: PageView(
          controller: pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AICampaignUpdateInputPage(
                navigateToNextPage: _navigateToNextPage,
                campaignId: widget.campaignId),
            AICampaignUpdateResultPage(
              onPopulateResult: widget.onPopulateResult,
            ),
          ],
        ),
      ),
    );
  }
}

class AICampaignUpdateInputPage extends StatefulWidget {
  final String campaignId;
  final VoidCallback navigateToNextPage;
  const AICampaignUpdateInputPage({
    super.key,
    required this.navigateToNextPage,
    required this.campaignId,
  });

  @override
  State<AICampaignUpdateInputPage> createState() =>
      _AICampaignUpdateInputPageState();
}

class _AICampaignUpdateInputPageState extends State<AICampaignUpdateInputPage> {
  final topicController = TextEditingController();
  static final recommendedTopics = <String>[
    "We've reached 50% of our funding goal!",
    "Excited to announce our new partnership NPO!",
    "See how your donations are making a difference in [beneficiary name]'s life!",
    "A heartfelt thank you to all our supporters!",
    "A big thank you to all our volunteers who made this possible!",
  ];

  void _handleSubmit() {
    final payload = CampaignUpdateRecommendationPayload(
      campaignId: widget.campaignId,
      topic: topicController.text,
    );
    context
        .read<CreateCampaignUpdateBloc>()
        .add(OnCreateCampaignUpdateRecommendation(payload: payload));
    widget.navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "AI Assistant Campaign Update Post",
            style: CustomFonts.labelMedium,
          ),
          4.kH,
          Text(
            "Generate better campaign update post with our NEW AI model to engage your donors.",
            style: CustomFonts.labelSmall.copyWith(
              color: CustomColors.textGrey,
            ),
          ),
          20.kH,
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/offer-fire.svg",
                width: 18,
                height: 18,
              ),
              4.kW,
              Text(
                "Other fundraisers also post:",
                style: CustomFonts.titleSmall
                    .copyWith(color: CustomColors.textDarkGreen),
              ),
            ],
          ),
          4.kH,
          RawScrollbar(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: recommendedTopics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      topicController.text = recommendedTopics[index];
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.containerBorderSlate),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        recommendedTopics[index],
                        style: CustomFonts.bodySmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          20.kH,
          const Text(
            "What you want to share?",
            style: CustomFonts.labelMedium,
          ),
          4.kH,
          CustomOutlinedTextfield(
            label: "Topic",
            controller: topicController,
          ),
          const Spacer(),
          SizedBox(
            width: double.maxFinite,
            child: CustomButton(
              onPressed: _handleSubmit,
              child: const Text("Generate"),
            ),
          )
        ],
      ),
    );
  }
}

class AICampaignUpdateResultPage extends StatelessWidget {
  final void Function(CampaignUpdateRecommendation result) onPopulateResult;
  const AICampaignUpdateResultPage({
    super.key,
    required this.onPopulateResult,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignUpdateBloc, CreateCampaignUpdateState>(
      builder: (context, state) {
        final updateRecommendationResult = state.updateRecommendationResult;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                100 *
                60,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "AI Assistant Campaign Update Post",
                    style: CustomFonts.labelMedium,
                  ),
                  4.kH,
                  Text(
                    "Generate better campaign update post with our NEW AI model to engage your donors.",
                    style: CustomFonts.labelSmall.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  ),
                  20.kH,
                  const Text(
                    "Title:",
                    style: CustomFonts.labelMedium,
                  ),
                  4.kH,
                  if (updateRecommendationResult is ApiResultLoading)
                    const Skeleton(
                      width: double.maxFinite,
                      height: Dimensions.loadingBodyHeight,
                      radius: 4,
                    ),
                  if (updateRecommendationResult
                      is ApiResultSuccess<CampaignUpdateRecommendation>)
                    Text(
                      updateRecommendationResult.data.title,
                      style: CustomFonts.bodyMedium,
                    ),
                  16.kH,
                  const Text(
                    "Description:",
                    style: CustomFonts.labelMedium,
                  ),
                  4.kH,
                  if (updateRecommendationResult is ApiResultLoading)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const Skeleton(
                          width: double.maxFinite,
                          height: Dimensions.loadingBodyHeight,
                          margin: EdgeInsets.only(bottom: 6),
                          radius: 4,
                        );
                      },
                    ),
                  if (updateRecommendationResult
                      is ApiResultSuccess<CampaignUpdateRecommendation>)
                    Text(
                      updateRecommendationResult.data.description,
                      style: CustomFonts.bodyMedium,
                    ),
                  // const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      isLoading:
                          state.updateRecommendationResult is ApiResultLoading,
                      enabled:
                          state.updateRecommendationResult is! ApiResultLoading,
                      onPressed: () {
                        if (updateRecommendationResult
                            is ApiResultSuccess<CampaignUpdateRecommendation>) {
                          onPopulateResult(updateRecommendationResult.data);
                        }
                        context.pop();
                      },
                      child: const Text("Continue to edit"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
