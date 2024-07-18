import 'package:bloc_test/bloc_test.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/update_user_profile.dart';
import 'package:crowdfunding_flutter/state_management/account_preferences/account_preferences_bloc.dart';
import 'package:crowdfunding_flutter/state_management/account_preferences/account_preferences_event.dart';
import 'package:crowdfunding_flutter/state_management/account_preferences/account_preferences_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateUserProfileUseCase extends Mock implements UpdateUserProfile {}

void main() {
  group("AccountPreferenceBloc", () {
    late UserModel user;
    late UpdateUserProfile updateUserProfile;
    late AccountPreferencesBloc accountPreferencesBloc;

    setUp(() async {
      registerFallbackValue(UserProfilePayload());
      user = UserModel.sample;
      updateUserProfile = MockUpdateUserProfileUseCase();
      accountPreferencesBloc =
          AccountPreferencesBloc(updateUserProfile: updateUserProfile);
      when(() => updateUserProfile.call(any())).thenAnswer(
        (invocation) async {
          return right(user);
        },
      );
    });

    test("initial state is correct", () {
      final bloc = AccountPreferencesBloc(updateUserProfile: updateUserProfile);
      expect(bloc.state.updateUserResult, const ApiResultInitial<UserModel>());
    });

    group('initialize selected categories', () {
      blocTest<AccountPreferencesBloc, AccountPreferencesState>(
        'emits new selected category ids',
        build: () => accountPreferencesBloc,
        act: (bloc) => bloc.add(OnInitSelectedCategoryIds(currentUser: user)),
        expect: () => [
          AccountPreferencesState(
              updateUserResult: const ApiResultInitial<UserModel>(),
              selectedCategoryIds: user.preference?.favouriteCampaignCategories
                      .map((e) => e.id)
                      .toList() ??
                  [])
        ],
      );
    });

    group('select category', () {
      blocTest(
        'emits new category id when received id is not selected yet',
        build: () => accountPreferencesBloc,
        act: (bloc) => bloc.add(const OnSelectCategory(id: 'new-id')),
        expect: () => [
          const AccountPreferencesState(
            updateUserResult: ApiResultInitial<UserModel>(),
            selectedCategoryIds: ['new-id'],
          ),
        ],
      );

      blocTest(
        'emits updated category ids when received id is already selected',
        build: () => accountPreferencesBloc,
        seed: () => const AccountPreferencesState(
            selectedCategoryIds: ['1', '2'],
            updateUserResult: ApiResultInitial<UserModel>()),
        act: (bloc) => bloc.add(const OnSelectCategory(id: '2')),
        expect: () => [
          const AccountPreferencesState(
            updateUserResult: ApiResultInitial<UserModel>(),
            selectedCategoryIds: ['1'],
          ),
        ],
      );
    });

    group('update user profile', () {
      blocTest('emit [loading, initial] when data is valid',
          build: () => accountPreferencesBloc,
          act: (bloc) => bloc.add(
                OnUpdateUser(
                  onSuccess: (user) {},
                ),
              ),
          expect: () => [
                const AccountPreferencesState(
                    selectedCategoryIds: [],
                    updateUserResult: ApiResultLoading<UserModel>()),
                const AccountPreferencesState(
                    selectedCategoryIds: [],
                    updateUserResult: ApiResultInitial<UserModel>()),
              ]);
    });
  });
}
