import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_category_tag.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_favourite_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/donation_progress_bar.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/match_offer_content.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/common/widgets/tag/custom_tag.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as videoPlayer;
import 'package:visibility_detector/visibility_detector.dart';

class AutoPlayVisibleVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isInteractive;
  const AutoPlayVisibleVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isInteractive = false,
  });

  @override
  State<AutoPlayVisibleVideoPlayer> createState() =>
      _AutoPlayVisibleVideoPlayerState();
}

class _AutoPlayVisibleVideoPlayerState
    extends State<AutoPlayVisibleVideoPlayer> {
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1.0) {
      // Video is fully visible, play the video
      _controller.play();
    } else if (info.visibleFraction < 0.7) {
      // Video is less than 50% visible, pause the video
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInteractive) {
      return VisibilityDetector(
        key: Key(widget.videoUrl),
        onVisibilityChanged: _handleVisibilityChanged,
        child: Container(
          color: Colors.black,
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CustomVideoPlayer(
                      customVideoPlayerController:
                          _customVideoPlayerController),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Container(
        color: Colors.black,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: videoPlayer.VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final double? height;
  final Campaign campaign;
  final bool isSmall;
  final Widget? headerLeadingTag;
  final Widget? headerTrailingTag;
  final Widget? footerAction;
  final VoidCallback? onPressed;
  const CampaignCard({
    this.campaign = Campaign.sample,
    super.key,
    this.isSmall = false,
    this.onPressed,
    this.height,
    this.headerLeadingTag,
    this.headerTrailingTag,
    this.footerAction,
  });

  Widget _buildMedia() {
    if (campaign.videoUrl != null && campaign.videoUrl!.isNotEmpty) {
      return AutoPlayVisibleVideoPlayer(
        videoUrl: campaign.videoUrl!,
      );
    }
    return CachedNetworkImage(
      imageUrl: campaign.thumbnailUrl,
      placeholder: (context, url) => const Skeleton(
        radius: 0,
      ),
      errorWidget: (context, url, error) => const Skeleton(
        radius: 0,
      ),
      fit: BoxFit.cover,
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth > 393
        ? 343
        : deviceWidth - (Dimensions.screenHorizontalPadding * 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: InkWell(
              onTap: onPressed,
              child: Ink(
                width: isSmall ? null : cardWidth,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.40 / 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            child: _buildMedia(),
                          ),
                        ),
                        if (headerLeadingTag != null)
                          Positioned(
                            top: 8.0,
                            left: 8.0,
                            child: headerLeadingTag!,
                          ),
                        if (headerTrailingTag != null)
                          Positioned(
                            top: 5.0,
                            right: 8.0,
                            child: headerTrailingTag!,
                          ),
                      ],
                    ),
                    8.kH,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isSmall ? 8.0 : 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isSmall)
                                      Text(
                                        "${campaign.createdAt.toISODate()} (${campaign.createdAt.toTimeAgo()})",
                                        style: CustomFonts.labelExtraSmall
                                            .copyWith(
                                                color: CustomColors.textGrey),
                                      ),
                                    if (!isSmall) 8.kH,
                                    Row(
                                      children: [
                                        CampaignCategoryTag(
                                          isSmall: true,
                                          category: campaign.campaignCategory,
                                        ),
                                        if (!isSmall)
                                          CustomTag(
                                            label: "65% Raised",
                                          ),
                                        // if (isSmall) MatchOfferTag(),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                if (!isSmall)
                                  CampaignFavouriteButton(
                                    onPressed: () {},
                                    campaign: campaign,
                                  ),
                              ],
                            ),
                          ),
                          6.kH,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isSmall ? 8.0 : 12.0),
                            child: Text(
                              campaign.title,
                              style: isSmall ? null : CustomFonts.titleMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          16.kH,
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: isSmall ? 8.0 : 12.0,
                              right: isSmall ? 8.0 : 12.0,
                              bottom: isSmall ? 8.0 : 0.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DonationProgressBar(
                                  total: campaign.targetAmount,
                                  current: campaign.raisedAmount.toDouble(),
                                  height: isSmall ? 8 : 10,
                                  showDonationStatusText: !isSmall,
                                ),
                              ],
                            ),
                          ),
                          if (footerAction != null)
                            Padding(
                              padding: EdgeInsets.only(
                                left: isSmall ? 8.0 : 12.0,
                                right: isSmall ? 8.0 : 12.0,
                                bottom: isSmall ? 8.0 : 0.0,
                              ),
                              child: footerAction,
                            ),
                          if (!isSmall) 12.kH,
                          // Top border for Match Offer container
                          if (!isSmall)
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: Colors.black,
                            ),
                          if (!isSmall) MatchOfferContent()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
