import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class CampaignLoadingCard extends StatelessWidget {
  final bool isSmall;
  final double height;
  const CampaignLoadingCard({
    super.key,
    this.isSmall = false,
    this.height = 500,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth > 393
        ? 343
        : deviceWidth - (Dimensions.screenHorizontalPadding * 2);
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: isSmall ? null : cardWidth,
      height: isSmall ? null : height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 1.3 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              child: Skeleton(
                radius: 0,
              ),
            ),
          ),
          8.kH,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSmall ? 8.0 : 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isSmall)
                            // Date
                            const Skeleton(
                              height: Dimensions.loadingBodyHeight,
                              width: 150,
                            ),
                          if (!isSmall) 8.kH,
                          const Row(
                            children: [
                              // Category
                              Skeleton(
                                height: 30,
                                width: 100,
                                radius: 100,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                12.kH,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSmall ? 8.0 : 12.0),
                  child: const Skeleton(
                    height: Dimensions.loadingTitleHeight,
                    width: double.maxFinite,
                  ),
                ),
                6.kH,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSmall ? 8.0 : 12.0),
                  child: const Skeleton(
                    height: Dimensions.loadingTitleHeight,
                    width: 200,
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
                      Container(
                        height: 10.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xFFF2F1F1),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
