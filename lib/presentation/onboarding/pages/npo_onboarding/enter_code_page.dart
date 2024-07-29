import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class EnterCodePage extends StatelessWidget {
  final VoidCallback onNextPage;
  const EnterCodePage({
    super.key,
    required this.onNextPage,
  });

  void _handleCodeChanged(BuildContext context, String value) {
    context.read<JoinNPOBloc>().add(OnCodeTextChanged(value));
  }

  void _handleSubmit(BuildContext context) {
    context.read<JoinNPOBloc>().add(
      OnFetchOrganization(
        onSuccess: () {
          onNextPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinNPOBloc, JoinNPOState>(
      listener: (context, state) {
        final searchOrganizationResult = state.searchOrganizationResult;
        if (searchOrganizationResult is ApiResultFailure<Organization>) {
          toastification.show(
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
            showProgressBar: true,
            applyBlurEffect: true,
            boxShadow: lowModeShadow,
            title: Text(searchOrganizationResult.errorMessage ??
                "Something went wrong"),
          );
        }
      },
      builder: (context, state) {
        final organizationResult = state.searchOrganizationResult;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your NPO invitation code",
                style: CustomFonts.titleLarge,
              ),
              24.kH,
              CustomOutlinedTextfield(
                initialValue: state.invitationCodeText,
                onChanged: (value) {
                  _handleCodeChanged(context, value);
                },
                errorText:
                    (organizationResult is ApiResultFailure<Organization>)
                        ? organizationResult.errorMessage
                        : null,
                hintText: "2k3Jz98",
                label: "Invitation code",
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      
                      style: CustomButtonStyle.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Back"),
                    ),
                  ),
                ],
              ),
              8.kH,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading:
                          state.searchOrganizationResult is ApiResultLoading,
                      onPressed: () {
                        _handleSubmit(context);
                      },
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
