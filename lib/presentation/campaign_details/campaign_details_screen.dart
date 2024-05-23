import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/donation_progress_bar.dart';
import 'package:crowdfunding_flutter/common/widgets/image_carousel.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
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
  static route({required String campaignId}) => MaterialPageRoute(
        builder: (context) => CampaignDetailsScreen(campaignId: campaignId),
      );
  const CampaignDetailsScreen({
    super.key,
    required this.campaignId,
  });

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  final commentTextController = TextEditingController();
  final commentFieldFocusNode = FocusNode();
  bool isShowingCommentBottomBar = false;

  void _handleOpenCommentBottomBar(BuildContext context) {
    context.read<CampaignDetailsBloc>().add(OnTabIndexChanged(2));
    setState(() {
      isShowingCommentBottomBar = true;
    });
    commentFieldFocusNode.requestFocus();
  }

  void _handleHideCommentBottomBar(BuildContext context) {
    context.read<CampaignDetailsBloc>().add(OnClearSelectedCommentToReply());
    setState(() {
      isShowingCommentBottomBar = false;
    });
  }

  void _handleCommentSubmit(BuildContext context) {
    final bloc = context.read<CampaignDetailsBloc>();
    final selectedCommentToReply = bloc.state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      // Reply
      final payload = CreateCampaignReplyPayload(
        campaignId: widget.campaignId,
        parentId: selectedCommentToReply.parentId ?? selectedCommentToReply.id,
        comment: commentTextController.text,
      );
      bloc.add(OnSubmitReply(payload));
    } else {
      // New comment (parent)
      final payload = CreateCampaignCommentPayload(
        campaignId: widget.campaignId,
        comment: commentTextController.text,
      );
      bloc.add(OnSubmitComment(payload));
    }
    _handleHideCommentBottomBar(context);
    commentTextController.clear();
  }

  void _handleReplyButtonPressed(
      BuildContext context, CampaignComment campaignComment) {
    context
        .read<CampaignDetailsBloc>()
        .add(OnSelectCommentToReply(campaignComment));
    setState(() {
      isShowingCommentBottomBar = true;
      commentFieldFocusNode.requestFocus();
    });
  }

  Widget _buildReplyBottomSheetTitle(CampaignDetailsState state) {
    final selectedCommentToReply = state.selectedCommentToReply;
    if (selectedCommentToReply != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "Reply to: @${selectedCommentToReply.user.fullName} “${selectedCommentToReply.comment}”",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.kH,
        ],
      );
    }
    return const SizedBox();
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
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 14.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReplyBottomSheetTitle(state),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: isShowingCommentBottomBar
                            ? CustomOutlinedTextfield(
                                controller: commentTextController,
                                focusNode: commentFieldFocusNode,
                                textInputAction: TextInputAction.send,
                                onFieldSubmitted: (value) {
                                  _handleCommentSubmit(context);
                                },
                              )
                            : CustomButton(
                                style: CustomButtonStyle.gradientGreen,
                                onPressed: () {},
                                child: const Text("Donate"),
                              ),
                      ),
                      8.kW,
                      isShowingCommentBottomBar
                          ? CustomIconButton(
                              onPressed: () {
                                _handleHideCommentBottomBar(context);
                              },
                              icon: const HeroIcon(HeroIcons.xMark),
                            )
                          : CustomIconButton(
                              onPressed: () {
                                _handleOpenCommentBottomBar(context);
                              },
                              icon: const HeroIcon(
                                  HeroIcons.chatBubbleLeftEllipsis),
                            ),
                      isShowingCommentBottomBar
                          ? CustomIconButton(
                              isLoading: state.createCommentResult
                                      is ApiResultLoading ||
                                  state.createReplyResult is ApiResultLoading,
                              enabled: state.createCommentResult
                                      is! ApiResultLoading &&
                                  state.createReplyResult is! ApiResultLoading,
                              onPressed: () {
                                _handleCommentSubmit(context);
                              },
                              icon: const HeroIcon(HeroIcons.paperAirplane),
                            )
                          : CustomIconButton(
                              onPressed: () {},
                              icon: const HeroIcon(HeroIcons.share),
                            )
                    ],
                  ),
                ],
              ),
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
                    ImageCarousel(
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
