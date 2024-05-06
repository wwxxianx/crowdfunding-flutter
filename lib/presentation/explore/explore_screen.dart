import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/tab/custom_tab_button.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isGridView = true;

  void _handleViewChange(bool value) {
    setState(() {
      isGridView = value;
    });
  }

  Widget _buildCampaignsContentLayout() {
    if (isGridView) {
      return GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.70,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(
          20,
          (index) => const CampaignCard(
            isSmall: true,
          ),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CampaignCard();
        },
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                    style: IconButtonStyle.white,
                    icon: HeroIcon(
                      HeroIcons.magnifyingGlass,
                      size: 30.0,
                      color: CustomColors.accentGreen,
                    ),
                    onPressed: () {},
                  ),
                  8.kW,
                  CustomIconButton(
                    onPressed: () {},
                    icon: HeroIcon(
                      HeroIcons.adjustmentsHorizontal,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //Header
                  HomePageHeader(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 15,
                      right: 15,
                    ),
                    title: "Let's help someone!",
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
          );
        },
      ),
    );
  }
}
