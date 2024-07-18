import 'dart:async';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationShowcase extends StatefulWidget {
  const OrganizationShowcase({
    super.key,
  });

  @override
  State<OrganizationShowcase> createState() => _OrganizationShowcaseState();
}

class _OrganizationShowcaseState extends State<OrganizationShowcase> {
  ScrollController scrollController = ScrollController();
  bool isScrolling = false;
  Timer? scrollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoScroll();
    });
  }

  void startAutoScroll() {
    if (scrollController.hasClients && !isScrolling) {
      double minScrollExtent = scrollController.position.minScrollExtent;
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      animateToMaxMin(maxScrollExtent, minScrollExtent, maxScrollExtent, 25, scrollController);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAutoScroll();
      });
    }
  }

  animateToMaxMin(
    double max,
    double min,
    double direction,
    int seconds,
    ScrollController scrollController,
  ) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then(
      (value) {
        if (!isScrolling) {
          direction = direction == max ? min : max;
          animateToMaxMin(max, min, direction, seconds, scrollController);
        }
      },
    );
  }

  void restartAutoScroll() {
    scrollTimer?.cancel();
    scrollTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        isScrolling = false;
      });
      startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final organizationsResult = state.organizationsResult;
        if (organizationsResult is ApiResultSuccess<List<Organization>>) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                setState(() {
                  isScrolling = true;
                });
              } else if (notification is ScrollEndNotification) {
                restartAutoScroll();
              }
              return false;
            },
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(
                  left: Dimensions.screenHorizontalPadding,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: organizationsResult.data.length,
                itemBuilder: (context, index) {
                  final organization = organizationsResult.data[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: CustomColors.containerBorderSlate),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              imageUrl: organization.imageUrl,
                              placeholder: organization.name[0],
                              size: 40,
                            ),
                            6.kW,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(organization.name,
                                    style: CustomFonts.labelSmall),
                                2.kH,
                                Text(
                                  "Joined since ${organization.createdAt.substring(0, 4)}",
                                  style: CustomFonts.bodyExtraSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        6.kH,
                        Text(
                          organization.slogan ??
                              "We love __ and we want to help someone. We love __ and we want to help someone.",
                          style: CustomFonts.bodyExtraSmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (organizationsResult is ApiResultLoading) {
          return const Text("Loading...");
        }
        if (organizationsResult is ApiResultFailure) {
          return const Text("Error...");
        }
        return const SizedBox();
      },
    );
  }
}
