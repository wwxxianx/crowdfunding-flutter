import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/image/gallery_photo_viewer.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/common/widgets/text/expandable_text.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CampaignUpdateTabContent extends StatelessWidget {
  const CampaignUpdateTabContent({super.key});

  Widget _buildContent(CampaignDetailsState state) {
    final campaignResult = state.campaignResult;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      if (campaignResult.data.campaignUpdates.isEmpty) {
        return const Text("Empty");
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...campaignResult.data.campaignUpdates.map((campaignUpdate) {
            return CampaignUpdateItem(campaignUpdate: campaignUpdate);
          }).toList(),
        ],
      );
    }
    if (campaignResult is ApiResultFailure) {
      return const Text("Something went wrong");
    }
    // Loading
    return Column(
      children: [
        const Skeleton(
          radius: 6,
          width: double.maxFinite,
          height: 200,
        ),
        12.kH,
        const Skeleton(
          height: Dimensions.loadingBodyHeight,
          width: 200,
        ),
        8.kH,
        const Skeleton(
          height: Dimensions.loadingTitleHeight,
          width: double.maxFinite,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildContent(state),
            ],
          ),
        );
      },
    );
  }
}

class CampaignUpdateItem extends StatelessWidget {
  final CampaignUpdate campaignUpdate;
  const CampaignUpdateItem({
    super.key,
    required this.campaignUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomColors.containerBorderGrey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (campaignUpdate.images != null &&
              campaignUpdate.images!.isNotEmpty)
            ImageCarouselWithNumberIndicator(
              images: campaignUpdate.images!,
            ),
          if (campaignUpdate.images != null &&
              campaignUpdate.images!.isNotEmpty)
            8.kH,
          Text(
            "${campaignUpdate.createdAt.toISODate()} - ${campaignUpdate.createdAt.toTime()}",
            style: CustomFonts.bodySmall.copyWith(color: CustomColors.textGrey),
          ),
          4.kH,
          Text(
            campaignUpdate.title,
            style: CustomFonts.labelMedium,
          ),
          4.kH,
          ExpandableText(
            text: campaignUpdate.description,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class ImageCarouselWithNumberIndicator extends StatefulWidget {
  final List<ImageModel> images;
  const ImageCarouselWithNumberIndicator({
    super.key,
    required this.images,
  });

  @override
  State<ImageCarouselWithNumberIndicator> createState() =>
      _ImageCarouselWithNumberIndicatorState();
}

class _ImageCarouselWithNumberIndicatorState
    extends State<ImageCarouselWithNumberIndicator> {
  late PageController _pageViewController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  void _handleExpandImage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: widget.images,
          backgroundDecoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          initialIndex: _currentPage,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          AspectRatio(
            aspectRatio: 1.25 / 1,
            child: PageView.builder(
              controller: _pageViewController,
              onPageChanged: _handlePageChange,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  // borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index].imageUrl,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 48,
                margin: const EdgeInsets.only(
                  top: 6,
                  right: 6,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black.withOpacity(0.3),
                  border: Border.all(
                    color: const Color(0xFFD2CFCF),
                    width: 1,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: '${_currentPage + 1}',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' / ${widget.images.length}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Color(0xFFD2CFCF),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: _handleExpandImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black.withOpacity(0.3),
                  border: Border.all(
                    color: const Color(0xFFD2CFCF),
                    width: 1,
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/expand.svg",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
