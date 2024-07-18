import 'package:badges/badges.dart' as badges;
import 'package:crowdfunding_flutter/common/theme/app_theme.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/badge.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_outlined_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_loading_card.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/animated_search_bar.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/animated_search_result_container.dart';
import 'package:crowdfunding_flutter/presentation/explore/widgets/filter_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExploreScreen extends StatefulWidget {
  static const String route = 'explore';
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
  bool isGridView = false;

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

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async {
    //     final giftCardBloc = context.read<GiftCardBloc>();
    //     if (giftCardBloc.state.shouldShowGiftCardDialog) {
    //       context.displayDialog(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text("testing"),
    //           ],
    //         ),
    //         onClose: () {
    //           giftCardBloc.add(OnCloseDialog());
    //         },
    //       );
    //     }
    //   },
    // );
  }

  void _showSearchResultContainer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _searchResultContainerController.forward();
    });
  }

  void _hideSearchResultContainer() {
    _searchResultContainerController.reverse();
  }

  void _handleViewChange(bool value) {
    setState(() {
      isGridView = value;
    });
  }

  void _handleOpenSearchBar() {
    setState(() {
      isSearching = true;
    });
  }

  void _handleHideMask() {
    setState(() {
      isSearching = false;
    });
  }

  void _handleSearch(BuildContext context, String value) {
    context.read<ExploreCampaignsBloc>()
      ..add(OnSearchQueryChanged(searchQuery: value))
      ..add(OnFetchCampaigns());
  }

  Widget _buildCampaignsContentLayout(ExploreCampaignsState state) {
    final campaignsResult = state.campaignsResult;
    if (isGridView) {
      if (campaignsResult is ApiResultSuccess<List<Campaign>> &&
          campaignsResult.data.isNotEmpty) {
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
                children: campaignsResult.data.mapWithIndex((campaign, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: CampaignCard(
                          campaign: Campaign.sample,
                          isSmall: true,
                        ),
                      ),
                    ),
                  );
                }).toList()));
      }
      // Other states
      return SizedBox();
    } else {
      if (campaignsResult is ApiResultSuccess<List<Campaign>> &&
          campaignsResult.data.isNotEmpty) {
        return AnimationLimiter(
          key: ValueKey<bool>(isGridView),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: campaignsResult.data.length,
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
                      child: CampaignCard(
                        campaign: campaignsResult.data[index],
                        onPressed: () {
                          context.push(CampaignDetailsScreen.generateRoute(
                              campaignId: campaignsResult.data[index].id));
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      if (campaignsResult is ApiResultFailure) {
        return Text("Something went wrong...");
      }
      // Loading
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            delay: const Duration(milliseconds: 200),
            child: const SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: CampaignLoadingCard(),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      child: BlocProvider(
        create: (context) =>
            ExploreCampaignsBloc(fetchCampaigns: serviceLocator())
              ..add(OnFetchCampaigns()),
        child: BlocBuilder<ExploreCampaignsBloc, ExploreCampaignsState>(
          builder: (context, state) {
            final isFilterEmpty = state.selectedCategoryIds.isEmpty ||
                state.selectedCategoryIds.isEmpty;
            return Scaffold(
              bottomSheet: Container(
                margin: const EdgeInsets.only(bottom: 8.0, right: 16.0),
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Filter button
                        CustomBadge(
                          badgeText:
                              "${state.selectedCategoryIds.length + state.selectedStateIds.length}",
                          showBadge: !isFilterEmpty,
                          position: badges.BadgePosition.topEnd(
                              end: isFilterEmpty ? 60 : 66),
                          child: Container(
                            margin:
                                EdgeInsets.only(right: isFilterEmpty ? 68 : 74),
                            child: CustomOutlinedIconButton(
                              border: Border.all(
                                color: CustomColors.containerBorderGreen,
                                width: 1.5,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context)
                                            .size
                                            .height -
                                        MediaQuery.of(context).viewPadding.top -
                                        120,
                                  ),
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return BlocProvider.value(
                                      value:
                                          BlocProvider.of<ExploreCampaignsBloc>(
                                              context),
                                      child: const CampaignsFilterBottomSheet(),
                                    );
                                  },
                                );
                              },
                              icon: const HeroIcon(
                                HeroIcons.adjustmentsHorizontal,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isSearching)
                              AnimatedSearchResultContainer(
                                scaleAnimation: _searchResultContainerAnimation,
                              ),
                            12.kH,
                            CustomBadge(
                              showBadge: state.searchQuery != null &&
                                  state.searchQuery!.isNotEmpty,
                              badgeText: "1",
                              child: AnimatedSearchBar(
                                autoFocus: true,
                                textInputAction: TextInputAction.search,
                                textController: _searchTextController,
                                width: MediaQuery.of(context).size.width -
                                    Dimensions.screenHorizontalPadding,
                                onSubmitted: (string) {
                                  _handleHideMask();
                                  _hideSearchResultContainer();
                                  _handleSearch(context, string);
                                },
                                onSuffixTap: () {
                                  _handleHideMask();
                                  _hideSearchResultContainer();
                                },
                                searchBarOpen: (integer) {
                                  _handleOpenSearchBar();
                                  _showSearchResultContainer();
                                },
                              ),
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
                            initialIndex: 1,
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
                            tabs: const <Widget>[
                              TabItem(
                                title: 'Grid',
                                prefixIcon: Icon(
                                  Symbols.grid_view_rounded,
                                  size: 16,
                                  color: CustomColors.textBlack,
                                  weight: 500,
                                ),
                              ),
                              TabItem(
                                title: 'List',
                                prefixIcon: HeroIcon(
                                  HeroIcons.listBullet,
                                  size: 16,
                                  color: CustomColors.textBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.kH,
                        _buildCampaignsContentLayout(state),
                      ],
                    ),
                  ),
                  if (isSearching) const ScaffoldMask()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
