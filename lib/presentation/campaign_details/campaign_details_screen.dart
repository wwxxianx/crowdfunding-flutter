import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/image_carousel.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/protect_info_banner.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CampaignDetailsScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CampaignDetailsScreen(),
      );
  const CampaignDetailsScreen({super.key});

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  final _textController = TextEditingController();
  final commentFieldFocusNode = FocusNode();
  bool isShowingCommentBottomBar = false;

  void _handleOpenCommentBottomBar() {
    setState(() {
      isShowingCommentBottomBar = true;
    });
    commentFieldFocusNode.requestFocus();
  }

  void _handleHideCommentBottomBar() {
    setState(() {
      isShowingCommentBottomBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: isShowingCommentBottomBar
                  ? CustomOutlinedTextfield(
                      controller: _textController,
                      focusNode: commentFieldFocusNode,
                    )
                  : CustomButton(
                      style: CustomButtonStyle.gradientGreen,
                      onPressed: () {},
                      child: const Text("Donate"),
                    ),
            ),
            8.kW,
            isShowingCommentBottomBar
                ? IconButton(
                    onPressed: _handleHideCommentBottomBar,
                    icon: HeroIcon(HeroIcons.xMark),
                  )
                : IconButton(
                    onPressed: _handleOpenCommentBottomBar,
                    icon: HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
                  ),
            isShowingCommentBottomBar
                ? IconButton(
                    onPressed: () {},
                    icon: HeroIcon(HeroIcons.paperAirplane),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: HeroIcon(HeroIcons.share),
                  )
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
          onPressed: () {},
          icon: const HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.black,
            size: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: Dimensions.bottomActionBarHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(),
            24.kH,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Campaign Title",
                    style: CustomFonts.titleExtraLarge,
                  ),
                  16.kH,
                  DonationProgressBar(
                    current: 3799,
                    total: 10000,
                    height: 12.0,
                  ),
                  16.kH,
                  CampaignCategoryTag(),
                  12.kH,
                  ProtectInfoBanner(),
                ],
              ),
            ),
            8.kH,
            CampaignDetailsTabView(
              onReplyButtonPreesed: (commentID) {},
            ),
          ],
        ),
      ),
    );
  }
}
