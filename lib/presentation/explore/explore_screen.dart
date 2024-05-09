import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/animated_search_bar.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/animated_search_result_container.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/filter_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum CampaignCategory {
  medical,
  education,
  animal,
  food,
  baby,
  emergency,
  environment,
  naturalDisaster,
}

extension CampaignCategoryExtension on CampaignCategory {
  Color getCampaignBGColor() {
    switch (this) {
      case CampaignCategory.medical:
        return const Color(0xFFFFF1F2);
      case CampaignCategory.education:
        return const Color(0xFFEFF6FF);
      case CampaignCategory.animal:
        return const Color(0xFFFFE4E6);
      case CampaignCategory.food:
        return const Color(0xFFECFDF5);
      case CampaignCategory.baby:
        return const Color(0xFFFDF4FF);
      case CampaignCategory.emergency:
        return const Color(0xFFFEF2F2);
      case CampaignCategory.environment:
        return const Color(0xFFFEFCE8);
      case CampaignCategory.naturalDisaster:
        return const Color(0xFFF0FDFA);
    }
  }

  Color getCampaignTextColor() {
    switch (this) {
      case CampaignCategory.medical:
        return const Color(0xFF9F1239);
      case CampaignCategory.education:
        return const Color(0xFF1E40AF);
      case CampaignCategory.animal:
        return const Color(0xFF92400E);
      case CampaignCategory.food:
        return const Color(0xFF065F46);
      case CampaignCategory.baby:
        return const Color(0xFF86198F);
      case CampaignCategory.emergency:
        return const Color(0xFFB91C1C);
      case CampaignCategory.environment:
        return const Color(0xFF854D0E);
      case CampaignCategory.naturalDisaster:
        return const Color(0xFF115E59);
    }
  }

  Widget getCampaignIcon({isSmall = false}) {
    final size = isSmall ? 16.0 : 20.0;

    switch (this) {
      case CampaignCategory.medical:
        return Icon(
          Symbols.ecg_heart_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.education:
        return Icon(
          Symbols.school_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.animal:
        return Icon(
          Symbols.pet_supplies_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.food:
        return Icon(
          Symbols.rice_bowl_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.baby:
        return Icon(
          Symbols.child_care_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.emergency:
        return Icon(
          Symbols.medical_services_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.environment:
        return Icon(
          Symbols.public_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategory.naturalDisaster:
        return Icon(
          Symbols.flood_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
    }
  }
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchResultContainerController;
  late Animation<double> _searchResultContainerAnimation;
  final _searchTextController = TextEditingController();
  bool isSearching = false;
  bool isShowingMask = false;
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    _searchResultContainerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _searchResultContainerAnimation = CurvedAnimation(
        parent: _searchResultContainerController, curve: Curves.fastOutSlowIn);
  }

  void _showSearchResultContainer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _searchResultContainerController.forward();
    });
  }

  void _hideContainer() {
    _searchResultContainerController.reverse();
  }

  void _handleViewChange(bool value) {
    setState(() {
      isGridView = value;
    });
  }

  void _handleShowMask() {
    setState(() {
      isShowingMask = true;
    });
  }

  void _handleHideMask() {
    setState(() {
      isShowingMask = false;
    });
  }

  Widget _buildCampaignsContentLayout() {
    if (isGridView) {
      return AnimationLimiter(
        key: ValueKey<bool>(isGridView),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.65,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            20,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: CampaignCard(
                      isSmall: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return AnimationLimiter(
        key: ValueKey<bool>(isGridView),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              delay: const Duration(milliseconds: 200),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: const CampaignCard(),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryGreen),
        useMaterial3: true,
        fontFamily: "Satoshi",
        scaffoldBackgroundColor: Colors.white,
      ),
      child: BlocBuilder<ExploreCampaignsBloc, ExploreCampaignsState>(
        builder: (context, state) {
          return Scaffold(
            bottomSheet: Container(
              margin: const EdgeInsets.only(bottom: 8.0, right: 10.0),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Filter button
                      Container(
                        margin: EdgeInsets.only(right: 68),
                        child: CustomIconButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return CampaignsFilterBottomSheet();
                              },
                            );
                          },
                          icon: HeroIcon(
                            HeroIcons.adjustmentsHorizontal,
                            size: 35.0,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedSearchResultContainer(
                            scaleAnimation: _searchResultContainerAnimation,
                          ),
                          12.kH,
                          AnimatedSearchBar(
                            autoFocus: true,
                            textController: _searchTextController,
                            width: MediaQuery.of(context).size.width -
                                Dimensions.screenHorizontalPadding,
                            onSubmitted: (string) {
                              _handleHideMask();
                              _hideContainer();
                            },
                            onSuffixTap: () {
                              _handleHideMask();
                              _hideContainer();
                              print("isSearching: $isSearching");
                            },
                            searchBarOpen: (integer) {
                              _handleShowMask();
                              _showSearchResultContainer();
                              print("isSearching: $isSearching");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //Header
                      HomePageHeader(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 15,
                          right: 10,
                        ),
                        title: "Let's help!",
                        action: CustomTab(
                          onTabItemChange: (tabIndex) {
                            switch (tabIndex) {
                              case 0:
                                _handleViewChange(true);
                                break;
                              case 1:
                                _handleViewChange(false);
                                break;
                            }
                          },
                          tabs: [
                            TabItem(
                              title: 'Grid',
                              prefixIcon: Icon(
                                Symbols.grid_view_rounded,
                                size: 16,
                                color: CustomColors.fontBlack,
                                weight: 500,
                              ),
                            ),
                            TabItem(
                              title: 'List',
                              prefixIcon: HeroIcon(
                                HeroIcons.listBullet,
                                size: 16,
                                color: CustomColors.fontBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.kH,
                      _buildCampaignsContentLayout(),
                    ],
                  ),
                ),
                if (isShowingMask) const ScaffoldMask()
              ],
            ),
          );
        },
      ),
    );
  }
}
