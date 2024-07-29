import 'package:crowdfunding_flutter/common/theme/color.dart';
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
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/tab_view.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/protect_info_banner.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/collaborate_with_npo_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/create_campaign_update_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/edit_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/prerequisite_content.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/reply_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class ManageCampaignDetailsScreen extends StatefulWidget {
  static const route = "/manage-campaign-details/:campaignId";
  static generateRoute({required String campaignId}) =>
      '/manage-campaign-details/$campaignId';
  final String campaignId;
  const ManageCampaignDetailsScreen({
    super.key,
    required this.campaignId,
  });

  @override
  State<ManageCampaignDetailsScreen> createState() =>
      _ManageCampaignDetailsScreenState();
}

class _ManageCampaignDetailsScreenState
    extends State<ManageCampaignDetailsScreen> {
  bool isShowingReplyBottomSheet = false;
  final replyFieldFocusNode = FocusNode();

  void _handleOpenReplyBottomSheet(
      BuildContext context, CampaignComment campaignComment) {
    context
        .read<CampaignDetailsBloc>()
        .add(OnSelectCommentToReply(campaignComment));
    setState(() {
      isShowingReplyBottomSheet = true;
    });
    replyFieldFocusNode.requestFocus();
  }

  void _handleCloseReplyBottomSheet() {
    setState(() {
      isShowingReplyBottomSheet = false;
    });
  }

  void _navigateToNewUpdate() {
    context.push(CreateCampaignUpdateScreen.generateRoute(
        campaignId: widget.campaignId));
  }

  void _navigateToEditScreen() {
    context
        .push(EditCampaignScreen.generateRoute(campaignId: widget.campaignId));
  }

  void _navigateToBankScreen(BuildContext context) {
    final campaignResult =
        context.read<CampaignDetailsBloc>().state.campaignResult;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      final stripeConnectId = campaignResult.data.user.bankAccount?.id ?? "";
      context.pushNamed('connected-bank-account',
          queryParameters: {'connectedAccountId': stripeConnectId});
      return;
    }
    // context.push('/connected-bank-account');
  }

  Widget _buildPublishStatusContent(Campaign campaign) {
    return campaign.statusEnum.buildStatusWidget();
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Color(0xFFDFDFDF),
              ),
            ),
          ),
          height: 67,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: _navigateToEditScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(HeroIcons.pencil),
                      6.kH,
                      const Text(
                        "Edit",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: _navigateToNewUpdate,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: _navigateToNewUpdate,
                              child: Container(
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100.0),
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8.0,
                                        spreadRadius: 3.0,
                                        offset: const Offset(0, 4),
                                        color: Colors.black.withOpacity(0.15),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        offset: const Offset(0, 1),
                                        color: Colors.black.withOpacity(0.30),
                                      ),
                                    ]),
                                width: 56,
                                height: 56,
                                child: const HeroIcon(
                                  HeroIcons.plus,
                                  color: CustomColors.primaryGreen,
                                ),
                              ),
                            ),
                            8.kH,
                            const Text(
                              "New Update",
                              style: CustomFonts.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    _navigateToBankScreen(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(HeroIcons.creditCard),
                      6.kH,
                      const Text(
                        "Bank",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.push(CollaborateWithNPOScreen.generateRoute(
                      campaignId: widget.campaignId,
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/organization.svg'),
                      6.kH,
                      const Text(
                        "Collaborate",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignDetailsBloc(
        createCampaignComment: serviceLocator(),
        createCampaignReply: serviceLocator(),
        fetchCampaign: serviceLocator(),
        createScamReport: serviceLocator(),
      )..add(OnFetchCampaign(widget.campaignId)),
      child: BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
        builder: (context, state) {
          final campaignResult = state.campaignResult;
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<CampaignDetailsBloc>()
                  .add(OnRefreshCampaign(widget.campaignId));
              return;
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              bottomNavigationBar: _buildBottomNavigationBar(context),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton.filledTonal(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.87),
                    ),
                  ),
                  onPressed: () {
                    context.go("/manage-campaigns");
                  },
                  icon: const HeroIcon(
                    HeroIcons.chevronLeft,
                    color: Colors.black,
                    size: 18.0,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
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
                              if (campaignResult is ApiResultSuccess<Campaign>)
                                _buildPublishStatusContent(campaignResult.data),
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
                              if (campaignResult is ApiResultSuccess<Campaign>)
                                DonationProgressBar(
                                  current: campaignResult.data.raisedAmount
                                      .toDouble(),
                                  total: campaignResult.data.targetAmount
                                      .toDouble(),
                                  height: 12.0,
                                ),
                              16.kH,
                              if (campaignResult is ApiResultSuccess<Campaign>)
                                CampaignCategoryTag(
                                  category:
                                      campaignResult.data.campaignCategory,
                                ),
                              12.kH,
                              const ProtectInfoBanner(),
                            ],
                          ),
                        ),
                        12.kH,
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenHorizontalPadding),
                          child: Text(
                            "Before starting your campaign",
                            style: CustomFonts.labelMedium,
                          ),
                        ),
                        8.kH,
                        if (campaignResult is ApiResultSuccess<Campaign>)
                          PrerequisiteContent(
                            campaignId: widget.campaignId,
                          ),
                        20.kH,
                        CampaignDetailsTabView(
                          onReplyButtonPreesed: (campaignComment) {
                            _handleOpenReplyBottomSheet(
                                context, campaignComment,
                                
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (isShowingReplyBottomSheet)
                    ReplyBottomSheet(
                      focusNode: replyFieldFocusNode,
                      onClose: _handleCloseReplyBottomSheet,
                      campaignId: widget.campaignId,
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
