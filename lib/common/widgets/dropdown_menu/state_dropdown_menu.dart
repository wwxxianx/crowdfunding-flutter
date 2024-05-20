import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/dropdown_menu/custom_dropdown_menu.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/usecases/fetch_state_and_regions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateAndRegionsCubit extends Cubit<ApiResult<List<StateAndRegion>>> {
  final FetchStateAndRegions _fetchStateAndRegions;
  StateAndRegionsCubit({required FetchStateAndRegions fetchStateAndRegions})
      : _fetchStateAndRegions = fetchStateAndRegions,
        super(ApiResultLoading());

  Future<void> fetchStateAndRegions() async {
    final res = await _fetchStateAndRegions.call(NoPayload());
    res.fold(
      (l) => emit(ApiResultFailure(l.errorMessage)),
      (r) => emit(ApiResultSuccess(r)),
    );
  }
}

class StateAndRegionsDropdownMenu extends StatefulWidget {
  final void Function(String)? onSelected;
  final String? initialSelection;
  final String? errorText;
  const StateAndRegionsDropdownMenu({
    super.key,
    this.onSelected,
    this.initialSelection,
    this.errorText,
  });

  @override
  State<StateAndRegionsDropdownMenu> createState() =>
      _StateAndRegionsDropdownMenuState();
}

class _StateAndRegionsDropdownMenuState
    extends State<StateAndRegionsDropdownMenu> {
  List<DropdownMenuEntry<String>> _buildDropdownMenuItems(
      ApiResult<List<StateAndRegion>> stateAndRegions) {
    if (stateAndRegions is ApiResultLoading ||
        stateAndRegions is ApiResultFailure) {
      return List.generate(1,
          (index) => const DropdownMenuEntry(value: "", label: "Loading..."));
    }
    return (stateAndRegions as ApiResultSuccess<List<StateAndRegion>>)
        .data
        .map((e) => DropdownMenuEntry(value: e.id, label: e.name.capitalize()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StateAndRegionsCubit(
        fetchStateAndRegions: serviceLocator(),
      )..fetchStateAndRegions(),
      child: BlocBuilder<StateAndRegionsCubit, ApiResult<List<StateAndRegion>>>(
        builder: (context, state) {
          if (state is ApiResultLoading) {
            return Text("loading...");
          } else if (state is ApiResultFailure) {
            return Text("error...");
          } else if (state is ApiResultSuccess) {
            return CustomDropdownMenu(
              errorText: widget.errorText,
              initialSelection: widget.initialSelection,
              dropdownMenuEntries: _buildDropdownMenuItems(state),
              onSelected: (stateId) {
                if (widget.onSelected != null && stateId != null) {
                  widget.onSelected!(stateId);
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
