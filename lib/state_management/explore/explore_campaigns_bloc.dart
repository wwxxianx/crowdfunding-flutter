import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCampaignsBloc
    extends Bloc<ExploreCampaignsEvent, ExploreCampaignsState> {
  ExploreCampaignsBloc() : super(ExploreCampaignsInitial()) {
    on<ExploreCampaignsEvent>(((event, emit) => ExploreCampaignsInitial()));
    on<OnViewChange>(_onViewChange);
  }

  void _onViewChange(
    OnViewChange event,
    Emitter<ExploreCampaignsState> emit,
  ) {
    if (event.isGridView && state is ExploreCampaignsGridView ||
        !event.isGridView && state is ExploreCampaignsListView) {
      return;
    }
    if (event.isGridView) {
      emit(ExploreCampaignsGridView());
    } else {
      emit(ExploreCampaignsListView()); 
    }
  }
}
