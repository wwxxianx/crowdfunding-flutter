import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final double? height;
  final double? width;
  final List<ImageModel> images;
  const ImageCarousel({
    super.key,
    this.height,
    this.width,
    required this.images,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
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

  void _handlePageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // late PageController _pageViewController;
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? MediaQuery.of(context).size.height / 2.75,
          child: PageView.builder(
            controller: _pageViewController,
            onPageChanged: _handlePageChange,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.images[index].imageUrl,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        8.kH,
        // Indicator
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => Container(
              margin: const EdgeInsets.only(right: 4.0),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _currentPage == index
                        ? Colors.black
                        : Colors.transparent),
                color: _currentPage == index
                    ? CustomColors.primaryGreen
                    : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
