import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/donation_progress_bar.dart';
import 'package:crowdfunding_flutter/common/widgets/image_carousel.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/protect_info_banner.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/tab_view.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final String campaignId;
  static const route = 'campaign-details/:campaignId';
  static generateRoute({required String campaignId}) =>
      'campaign-details/$campaignId';
  const CampaignDetailsScreen({
    super.key,
    required this.campaignId,
  });

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  final commentFieldFocusNode = FocusNode();

  void _handleReplyButtonPressed(
      BuildContext context, CampaignComment campaignComment) {
    context
        .read<CampaignDetailsBloc>()
        .add(OnSelectCommentToReply(campaignComment));
    commentFieldFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignDetailsBloc(
        fetchCampaign: serviceLocator(),
        createCampaignComment: serviceLocator(),
        createCampaignReply: serviceLocator(),
      )..add(OnFetchCampaign(widget.campaignId)),
      child: BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
        builder: (context, state) {
          final campaignResult = state.campaignResult;
          return Scaffold(
            extendBodyBehindAppBar: true,
            bottomSheet: CampaignDetailsBottomSheet(
              campaignId: widget.campaignId,
              commentFieldFocusNode: commentFieldFocusNode,
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton.filledTonal(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.87),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const HeroIcon(
                  HeroIcons.chevronLeft,
                  color: Colors.black,
                  size: 18.0,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: Dimensions.bottomActionBarHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (campaignResult is ApiResultLoading)
                    Skeleton(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.75,
                    ),
                  if (campaignResult is ApiResultSuccess<Campaign>)
                    MediaCarousel(
                      images: campaignResult.data.images,
                      videoUrls: campaignResult.data.videoUrl != null
                          ? [campaignResult.data.videoUrl!]
                          : [],
                    ),
                  24.kH,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.screenHorizontalPadding,
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (campaignResult is ApiResultLoading)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Skeleton(
                                height: Dimensions.loadingTitleHeight,
                                width: double.maxFinite,
                              ),
                              4.kH,
                              const Skeleton(
                                height: Dimensions.loadingTitleHeight,
                                width: 200,
                              ),
                            ],
                          ),
                        if (campaignResult is ApiResultSuccess<Campaign>)
                          Text(
                            campaignResult.data.title,
                            style: CustomFonts.titleExtraLarge,
                          ),
                        16.kH,
                        const DonationProgressBar(
                          current: 3799,
                          total: 10000,
                          height: 12.0,
                        ),
                        16.kH,
                        if (campaignResult is ApiResultSuccess<Campaign>)
                          CampaignCategoryTag(
                            category: campaignResult.data.campaignCategory,
                          ),
                        12.kH,
                        const ProtectInfoBanner(),
                      ],
                    ),
                  ),
                  8.kH,
                  CampaignDetailsTabView(
                    onReplyButtonPreesed: (campaignComment) {
                      _handleReplyButtonPressed(context, campaignComment);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
