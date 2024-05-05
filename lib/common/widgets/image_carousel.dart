import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  ImageCarousel({super.key});

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
    // TODO: implement dispose
    super.dispose();
    _pageViewController.dispose();
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<String> images = [
    "assets/images/campaign-image-sample.jpg",
    "assets/images/campaign-image-sample-2.jpg",
    "assets/images/campaign-image-sample-.jpg",
    "assets/images/campaign-image-sample-2.jpg",
  ];

  // late PageController _pageViewController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.75,
          child: PageView.builder(
            controller: _pageViewController,
            onPageChanged: _handlePageChange,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.asset(
                images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                margin: EdgeInsets.only(right: 4.0),
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
        ),
      ],
    );
  }
}
