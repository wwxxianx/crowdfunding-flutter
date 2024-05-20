import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/update_user_profile.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class PersonalOnboardingBloc
    extends Bloc<PersonalOnboardingEvent, PersonalOnboardingState> {
  final UpdateUserProfile _updateUserProfile;
  PersonalOnboardingBloc({
    required UpdateUserProfile updateUserProfile,
  })  : _updateUserProfile = updateUserProfile,
        super(const PersonalOnboardingState.initial()) {
    on<PersonalOnboardingEvent>(_onEvent);
  }

  Future<void> _onEvent(
    PersonalOnboardingEvent event,
    Emitter<PersonalOnboardingState> emit,
  ) async {
    return switch (event) {
      final OnProfileImageFileChanged e => _onProfileImageFileChanged(e, emit),
      final OnFullNameChanged e => _onFullNameChanged(e, emit),
      final OnSelectCategories e => _onSelectCategories(e, emit),
      final OnUpdateProfile e => _onUpdateProfile(e, emit),
    };
  }

  Future<void> _onUpdateProfile(
    OnUpdateProfile event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isUpdatingProfile: true));
    final payload = UserProfilePayload(
      isOnBoardingCompleted: true,
      favouriteCategoriesId: state.selectedCategoriesId,
      fullName: state.fullName,
      profileImageFile: state.profileImageFile,
      
    );
    final res = await _updateUserProfile.call(payload);
    res.fold(
      (l) {
        print('failed');
        emit(state.copyWith(
            updateProfileError: l.errorMessage, isUpdatingProfile: false));
      },
      (r) {
        print('success');
        event.onSuccess();
        emit(state.copyWith(isUpdatingProfile: false));
      },
    );
  }

  void _onProfileImageFileChanged(
    OnProfileImageFileChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(profileImageFile: event.file));
  }

  void _onFullNameChanged(
    OnFullNameChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onSelectCategories(
    OnSelectCategories event,
    Emitter emit,
  ) {
    final currentSelectedCategories = state.selectedCategoriesId;
    if (currentSelectedCategories.isEmpty) {
      emit(state.copyWith(selectedCategoriesId: [
        ...currentSelectedCategories,
        event.categoryId
      ]));
      return;
    }

    if (currentSelectedCategories.contains(event.categoryId)) {
      // Remove
      emit(state.copyWith(
          selectedCategoriesId: currentSelectedCategories
              .filter((id) => id != event.categoryId)
              .toList()));
    } else {
      emit(state.copyWith(selectedCategoriesId: [
        ...currentSelectedCategories,
        event.categoryId
      ]));
    }
  }
}
