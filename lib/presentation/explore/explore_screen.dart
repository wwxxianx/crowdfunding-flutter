import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/animated_search_bar.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:uuid/uuid.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchTextController = TextEditingController();
  bool isShowingMask = false;
  bool isGridView = true;

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
          key: ValueKey<bool>(isGridView),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.70,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            20,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                key: ValueKey<bool>(isGridView),
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  key: ValueKey<bool>(isGridView),
                  child: FadeInAnimation(
                    key: ValueKey<bool>(isGridView),
                    child: CampaignCard(
                      key: ValueKey<bool>(isGridView),
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
          key: ValueKey<bool>(isGridView),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              key: ValueKey<bool>(isGridView),
              position: index,
              duration: const Duration(milliseconds: 375),
              delay: const Duration(milliseconds: 200),
              child: SlideAnimation(
                key: ValueKey<bool>(isGridView),
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  key: ValueKey<bool>(isGridView),
                  child: Padding(
                    key: ValueKey<bool>(isGridView),
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
                      Container(
                        margin: EdgeInsets.only(right: 68),
                        child: CustomIconButton(
                          onPressed: () {},
                          icon: HeroIcon(
                            HeroIcons.adjustmentsHorizontal,
                            size: 35.0,
                          ),
                        ),
                      ),
                      AnimatedSearchBar(
                        autoFocus: true,
                        textController: _searchTextController,
                        width: MediaQuery.of(context).size.width -
                            Dimensions.screenHorizontalPadding,
                        onSubmitted: (string) {
                          _handleHideMask();
                        },
                        onSuffixTap: () {
                          _handleHideMask();
                        },
                        searchBarOpen: (integer) {
                          _handleShowMask();
                        },
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
