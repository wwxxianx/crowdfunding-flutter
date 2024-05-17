import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCampaignBloc
    extends Bloc<CreateCampaignEvent, CreateCampaignState> {
  CreateCampaignBloc()  : super(const CreateCampaignState.initial()) {
    on<CreateCampaignEvent>(_onEvent);
  }

  Future<void> _onEvent(CreateCampaignEvent event, Emitter emit) async {
    return switch (event) {
      final OnTargetAmountTextChanged e => _onTargetAmountTextChanged(e, emit),
      final CreateCampaignEvent _ => {
          emit(const CreateCampaignState.initial())
        },
    };
  }


  void _onTargetAmountTextChanged(
    OnTargetAmountTextChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(targetAmountText: event.targetAmount));
  }
}
