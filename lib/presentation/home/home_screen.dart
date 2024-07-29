import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/close_to_target_campaigns_list.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/header.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/organizations_showcase.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/slogan_banner.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/successful_campaigns_showcase.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/user_interested_campaigns_list.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const route = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _focusNode = FocusNode();
  bool showText = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeBloc>().add(OnInitData());
    context.read<GiftCardBloc>().add(OnFetchAllGiftCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomePageHeader(
                  title: "Welcome back!",
                ),
                SloganBanner(),
                CloseToTargetCampaignsList(),
                20.kH,
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.screenHorizontalPadding),
                  child: const Text(
                    "Our successful campaigns",
                    style: CustomFonts.titleLarge,
                  ),
                ),
                12.kH,
                SuccessfulCampaignsShowcase(),
                20.kH,
                UserInterestedCampaignsList(),
                20.kH,
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.screenHorizontalPadding),
                  child: const Text(
                    "Trusted and backed by NPOs",
                    style: CustomFonts.titleMedium,
                  ),
                ),
                12.kH,
                OrganizationShowcase(),
              ],
            );
          },
        ),
      ),
    );
  }
}
