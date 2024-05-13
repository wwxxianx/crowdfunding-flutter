import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/image_carousel.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/protect_info_banner.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/tab_view.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/create_campaign_update_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/reply_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class ManageCampaignDetailsScreen extends StatefulWidget {
  const ManageCampaignDetailsScreen({super.key});

  @override
  State<ManageCampaignDetailsScreen> createState() =>
      _ManageCampaignDetailsScreenState();
}

class _ManageCampaignDetailsScreenState
    extends State<ManageCampaignDetailsScreen> {
  bool isShowingReplyBottomSheet = false;
  final replyFieldFocusNode = FocusNode();

  void _handleOpenReplyBottomSheet() {
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
    Navigator.push(context, CreateCampaignUpdateScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Stack(
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
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/information-filled.svg"),
                        6.kH,
                        const Text(
                          "Details",
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
                                "Details",
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
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeroIcon(HeroIcons.pencil),
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
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeroIcon(HeroIcons.banknotes),
                        6.kH,
                        const Text(
                          "Donations",
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
      ),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: Dimensions.bottomActionBarHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageCarousel(),
                24.kH,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding,
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Campaign Title",
                        style: CustomFonts.titleExtraLarge,
                      ),
                      16.kH,
                      const DonationProgressBar(
                        current: 3799,
                        total: 10000,
                        height: 12.0,
                      ),
                      16.kH,
                      const CampaignCategoryTag(),
                      12.kH,
                      const ProtectInfoBanner(),
                    ],
                  ),
                ),
                8.kH,
                CampaignDetailsTabView(
                  onReplyButtonPreesed: (commentID) {
                    _handleOpenReplyBottomSheet();
                  },
                ),
              ],
            ),
          ),
          if (isShowingReplyBottomSheet)
            ReplyBottomSheet(
              focusNode: replyFieldFocusNode,
              onClose: _handleCloseReplyBottomSheet,
            ),
        ],
      ),
    );
  }
}
