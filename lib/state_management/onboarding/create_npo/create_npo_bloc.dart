import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/create_organization_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/create_organization.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class CreateNpoBloc extends Bloc<CreateNpoEvent, CreateNpoState>
    with InputValidator {
  final CreateOrganization _createOrganization;
  CreateNpoBloc({
    required CreateOrganization createOrganization,
  })  : _createOrganization = createOrganization,
        super(const CreateNpoState.initial()) {
    on<CreateNpoEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CreateNpoEvent event,
    Emitter<CreateNpoState> emit,
  ) async {
    return switch (event) {
      final OnRegistrationNumberChanged e =>
        _onRegistrationNumberChanged(e, emit),
      final OnImageFileChanged e => _onImageFileChanged(e, emit),
      final OnNpoNameChanged e => _onNpoNameChanged(e, emit),
      final OnEmailChanged e => _onEmailChanged(e, emit),
      final OnPhoneNumberChanged e => _onPhoneNumberChanged(e, emit),
      final OnCreateOrganization e => _onCreateOrganization(e, emit),
    };
  }

  Future<void> _onCreateOrganization(
    OnCreateOrganization event,
    Emitter<CreateNpoState> emit,
  ) async {
    // Validate data
    emit(state.copyWith(createOrganizationResult: const ApiResultLoading()));
    final npoNameResult = validateStringWithMinMaxLength(
      title: 'Organization name',
      value: state.npoName,
      minLength: 1,
      maxLength: 100,
    );
    final npoEmailResult = validateEmail(state.npoEmail);
    final npoPhoneNumberResult = validatePhoneNumber(state.npoPhoneNumber);
    final hasError = <InputValidationResult>[
      npoNameResult,
      npoEmailResult,
      npoPhoneNumberResult,
    ].any((element) => !element.successful);
    if (hasError) {
      emit(state.copyWith(
        npoNameError: npoNameResult.errorMessage,
        npoEmailError: npoEmailResult.errorMessage,
        npoPhoneNumberError: npoPhoneNumberResult.errorMessage,
        createOrganizationResult: const ApiResultInitial(),
      ));
      return;
    }
    emit(state.copyWith(
      npoNameError: null,
      npoEmailError: null,
      npoPhoneNumberError: null,
    ));
    final payload = CreateOrganizationPayload(
      // registrationNumber: state.registrationNumber!,
      npoName: state.npoName!,
      npoEmail: state.npoEmail!,
      npoContactPhoneNumber: state.npoPhoneNumber!,
      imageFile: state.imageFile,
    );
    final res = await _createOrganization.call(payload);
    res.fold(
      (failure) {
        var logger = Logger();
        logger.w(failure.errorMessage);
        emit(state.copyWith(createOrganizationResult: ApiResultFailure(failure.errorMessage)));
      },
      (userModel) {
        emit(state.copyWith(
            createOrganizationResult: ApiResultSuccess(userModel)));
        event.onSuccess();
      },
    );
  }

  void _onImageFileChanged(
    OnImageFileChanged event,
    Emitter<CreateNpoState> emit,
  ) {
    emit(state.copyWith(imageFile: event.imageFile));
  }

  void _onRegistrationNumberChanged(
    OnRegistrationNumberChanged event,
    Emitter<CreateNpoState> emit,
  ) {
    emit(state.copyWith(registrationNumber: event.value));
  }

  void _onNpoNameChanged(
    OnNpoNameChanged event,
    Emitter<CreateNpoState> emit,
  ) {
    emit(state.copyWith(npoName: event.value));
  }

  void _onEmailChanged(
    OnEmailChanged event,
    Emitter<CreateNpoState> emit,
  ) {
    emit(state.copyWith(npoEmail: event.value));
  }

  void _onPhoneNumberChanged(
    OnPhoneNumberChanged event,
    Emitter<CreateNpoState> emit,
  ) {
    emit(state.copyWith(npoPhoneNumber: event.value));
  }
}
