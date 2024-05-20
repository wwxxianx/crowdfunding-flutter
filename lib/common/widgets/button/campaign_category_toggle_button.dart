import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignCategoriesCubit extends Cubit<ApiResult<List<CampaignCategory>>> {
  final FetchCampaignCategories _fetchCampaignCategories;
  CampaignCategoriesCubit({
    required FetchCampaignCategories fetchCampaignCategories,
  })  : _fetchCampaignCategories = fetchCampaignCategories,
        super(ApiResultLoading());

  Future<void> fetchCampaignCategories() async {
    final res = await _fetchCampaignCategories.call(NoPayload());
    res.fold(
      (l) => emit(ApiResultFailure(l.errorMessage)),
      (r) => emit(ApiResultSuccess(r)),
    );
  }
}

enum CampaignCategoryEnum {
  medical,
  education,
  animal,
  food,
  baby,
  emergency,
  environment,
  naturalDisaster,
}

extension CampaignCategoryExtension on CampaignCategoryEnum {
  Color getCampaignBGColor() {
    switch (this) {
      case CampaignCategoryEnum.medical:
        return const Color(0xFFFFF1F2);
      case CampaignCategoryEnum.education:
        return const Color(0xFFEFF6FF);
      case CampaignCategoryEnum.animal:
        return const Color(0xFFFFE4E6);
      case CampaignCategoryEnum.food:
        return const Color(0xFFECFDF5);
      case CampaignCategoryEnum.baby:
        return const Color(0xFFFDF4FF);
      case CampaignCategoryEnum.emergency:
        return const Color(0xFFFEF2F2);
      case CampaignCategoryEnum.environment:
        return const Color(0xFFFEFCE8);
      case CampaignCategoryEnum.naturalDisaster:
        return const Color(0xFFF0FDFA);
    }
  }

  Color getCampaignTextColor() {
    switch (this) {
      case CampaignCategoryEnum.medical:
        return const Color(0xFF9F1239);
      case CampaignCategoryEnum.education:
        return const Color(0xFF1E40AF);
      case CampaignCategoryEnum.animal:
        return const Color(0xFF92400E);
      case CampaignCategoryEnum.food:
        return const Color(0xFF065F46);
      case CampaignCategoryEnum.baby:
        return const Color(0xFF86198F);
      case CampaignCategoryEnum.emergency:
        return const Color(0xFFB91C1C);
      case CampaignCategoryEnum.environment:
        return const Color(0xFF854D0E);
      case CampaignCategoryEnum.naturalDisaster:
        return const Color(0xFF115E59);
    }
  }

  Widget getCampaignIcon({isSmall = false}) {
    final size = isSmall ? 16.0 : 20.0;

    switch (this) {
      case CampaignCategoryEnum.medical:
        return Icon(
          Symbols.ecg_heart_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.education:
        return Icon(
          Symbols.school_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.animal:
        return Icon(
          Symbols.pet_supplies_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.food:
        return Icon(
          Symbols.rice_bowl_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.baby:
        return Icon(
          Symbols.child_care_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.emergency:
        return Icon(
          Symbols.medical_services_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.environment:
        return Icon(
          Symbols.public_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
      case CampaignCategoryEnum.naturalDisaster:
        return Icon(
          Symbols.flood_rounded,
          size: size,
          color: getCampaignTextColor(),
        );
    }
  }
}

class CampaignCategoryList extends StatelessWidget {
  final List<String> selectedCategoryIds;
  final void Function(CampaignCategory campaignCategory) onPressed;

  CampaignCategoryList({
    super.key,
    required this.onPressed,
    required this.selectedCategoryIds,
  });

  List<Widget> _buildContent(ApiResult campaignCategories) {
    if (campaignCategories is ApiResultLoading ||
        campaignCategories is ApiResultFailure) {
      return List.generate(5, (index) {
        return const Skeleton(
          radius: 100,
        );
      });
    }
    return (campaignCategories as ApiResultSuccess<List<CampaignCategory>>)
        .data
        .map(
          (category) => CampaignCategoryToggleButton(
            campaignCategory: category,
            onPressed: (campaignCategory) {
              onPressed(campaignCategory);
            },
            isSelected: selectedCategoryIds.contains(category.id),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CampaignCategoriesCubit(fetchCampaignCategories: serviceLocator())
            ..fetchCampaignCategories(),
      child: BlocBuilder<CampaignCategoriesCubit,
          ApiResult<List<CampaignCategory>>>(
        builder: (context, state) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            children: _buildContent(state),
          );
        },
      ),
    );
  }
}

class CampaignCategoryToggleButton extends StatelessWidget {
  final bool isSelected;
  final CampaignCategory campaignCategory;
  final void Function(CampaignCategory campaignCategory) onPressed;
  const CampaignCategoryToggleButton({
    super.key,
    required this.campaignCategory,
    required this.onPressed,
    required this.isSelected,
  });

  void _handleToggle() {
    onPressed(campaignCategory);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: _handleToggle,
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 12.0,
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100.0),
              color: CampaignCategoryEnum.values
                  .byName(campaignCategory.title)
                  .getCampaignBGColor(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CampaignCategoryEnum.values
                    .byName(campaignCategory.title)
                    .getCampaignIcon(),
                4.kW,
                Text(
                  campaignCategory.title.capitalize(),
                  style: CustomFonts.labelMedium.copyWith(
                    color: CampaignCategoryEnum.values
                        .byName(campaignCategory.title)
                        .getCampaignTextColor(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
