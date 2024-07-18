import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/create_campaign.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateCampaignUseCase extends Mock implements CreateCampaign {}

void main() {
  group('CreateCampaignBloc', () {
    late CampaignSummary mockData;
    late CreateCampaign createCampaign;
    late CreateCampaignBloc createCampaignBloc;

    setUp(() {
      mockData = CampaignSummary.samples.first;
      registerFallbackValue(CreateCampaignPayload(
          title: mockData.title,
          description: mockData.description,
          targetAmount: mockData.targetAmount.toInt(),
          categoryId: '',
          phoneNumber: '',
          stateId: '',
          beneficiaryName: mockData.beneficiaryName,
          campaignImageFiles: [File('')]));
      createCampaign = MockCreateCampaignUseCase();
      createCampaignBloc = CreateCampaignBloc(createCampaign: createCampaign);
    });

    test('initial state is correct', () {
      expect(createCampaignBloc.state, const CreateCampaignState.initial());
    });

    group('Insert campaign data', () {
      const title = "Campaign Title";
      const description = "Campaign Description";
      const targetAmount = "100";
      const categoryId = "1";
      const phoneNumber = "1234567890";
      const stateId = "1";
      const beneficiaryName = "Beneficiary Name";

      blocTest(
        'Insert title',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnTitleChanged(title: title)),
        expect: () => [
          createCampaignBloc.state.copyWith(titleText: title),
        ],
      );

      blocTest(
        'Insert description',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnDescriptionChanged(description: description)),
        expect: () => [
          createCampaignBloc.state.copyWith(descriptionText: description),
        ],
      );

      blocTest(
        'Insert target amount',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnTargetAmountTextChanged(targetAmount: targetAmount)),
        expect: () => [
          createCampaignBloc.state.copyWith(targetAmountText: targetAmount),
        ],
      );

      blocTest(
        'Select category ID',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnSelectCampaignCategory(categoryId: categoryId)),
        expect: () => [
          createCampaignBloc.state.copyWith(selectedCategoryId: categoryId),
        ],
      );

      blocTest(
        'Insert phone number',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnPhoneNumberChanged(phoneNumber: phoneNumber)),
        expect: () => [
          createCampaignBloc.state.copyWith(phoneNumberText: phoneNumber),
        ],
      );

      blocTest(
        'Select state ID',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnSelectState(stateId: stateId)),
        expect: () => [
          createCampaignBloc.state.copyWith(selectedStateId: stateId),
        ],
      );

      blocTest(
        'Insert beneficiary name',
        build: () => createCampaignBloc,
        act: (bloc) => bloc.add(const OnBeneficiaryNameChanged(beneficiaryName: beneficiaryName)),
        expect: () => [
          createCampaignBloc.state.copyWith(beneficiaryNameText: beneficiaryName),
        ],
      );
    });

    group('Create campaign', () {
      blocTest<CreateCampaignBloc, CreateCampaignState>(
        'emit [loading, success] when creating campaign succeeds',
        seed: () =>
            createCampaignBloc.state.copyWith(campaignImageFiles: [File('')]),
        build: () {
          when(() => createCampaign.call(any())).thenAnswer(
            (_) async => right(CampaignSummary.samples.first),
          );
          return createCampaignBloc;
        },
        act: (bloc) => bloc.add(
          OnCreateCampaign(onSuccess: (id) {}),
        ),
        expect: () => [
          createCampaignBloc.state
              .copyWith(createCampaignResult: const ApiResultLoading()),
          createCampaignBloc.state.copyWith(
              createCampaignResult:
                  ApiResultSuccess(CampaignSummary.samples.first)),
        ],
      );

      blocTest<CreateCampaignBloc, CreateCampaignState>(
        'emit [loading, failure] when no campaign image files uploaded',
        build: () {
          when(() => createCampaign.call(any())).thenAnswer(
            (_) async => left(Failure('Please upload campaign images')),
          );
          return createCampaignBloc;
        },
        act: (bloc) => bloc.add(
          OnCreateCampaign(onSuccess: (id) {}),
        ),
        expect: () => [
          createCampaignBloc.state
              .copyWith(createCampaignResult: const ApiResultLoading()),
          createCampaignBloc.state.copyWith(
              createCampaignResult:
                  ApiResultFailure('Please upload campaign images')),
        ],
      );
    });
  });
}
