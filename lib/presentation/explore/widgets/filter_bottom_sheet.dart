import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/dropdown_menu/state_dropdown_menu.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CampaignsFilterBottomSheet extends StatelessWidget {
  const CampaignsFilterBottomSheet({
    super.key,
  });

  void _handleSelectCategory(
      BuildContext context, CampaignCategory campaignCategory) {
    context
        .read<ExploreCampaignsBloc>()
        .add(OnSelectCampaignCategory(categoryId: campaignCategory.id));
  }

  void _handleSelectState(BuildContext context, StateAndRegion stateAndRegion) {
    context
        .read<ExploreCampaignsBloc>()
        .add(OnSelectStateAndRegion(stateId: stateAndRegion.id));
  }

  void _handleApplyFilter(BuildContext context) {
    context.read<ExploreCampaignsBloc>().add(OnFetchCampaigns());
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCampaignsBloc, ExploreCampaignsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.95,
          footer: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                horizontal:
                    BorderSide(color: CustomColors.containerBorderSlate),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onPressed: () {
                    _handleApplyFilter(context);
                  },
                  child: const Text("Apply filter"),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                CampaignCategoryList(
                  onPressed: (campaignCategory) {
                    _handleSelectCategory(context, campaignCategory);
                  },
                  selectedCategoryIds: state.selectedCategoryIds,
                ),
                20.kH,
                //Divider
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: CustomColors.divider,
                  ),
                ),
                20.kH,
                const Text(
                  "Location",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                StateAndRegionChecklist(
                  selectedStateIds: state.selectedStateIds,
                  onChecked: (stateAndRegion) {
                    _handleSelectState(context, stateAndRegion);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StateAndRegionChecklist extends StatelessWidget {
  final List<String> selectedStateIds;
  final void Function(StateAndRegion stateAndRegion)? onChecked;
  const StateAndRegionChecklist({
    super.key,
    this.onChecked,
    required this.selectedStateIds,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StateAndRegionsCubit(fetchStateAndRegions: serviceLocator())
            ..fetchStateAndRegions(),
      child: BlocBuilder<StateAndRegionsCubit, ApiResult<List<StateAndRegion>>>(
        builder: (context, state) {
          if (state is ApiResultSuccess<List<StateAndRegion>>) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value:
                      selectedStateIds.any((id) => id == state.data[index].id),
                  onChanged: (value) {
                    onChecked?.call(state.data[index]);
                  },
                  title: Text(
                    state.data[index].name.toTitleCase(),
                    style: CustomFonts.labelMedium,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                );
              },
            );
          }
          if (state is ApiResultFailure) {
            return const Text(
              "Failed to get the state data, please try again later.",
            );
          }
          return const Skeleton(
            width: double.maxFinite,
          );
        },
      ),
    );
  }
}
