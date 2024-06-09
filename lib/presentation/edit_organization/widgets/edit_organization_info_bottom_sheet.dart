import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class EditOrganizationInfoBottomSheet extends StatelessWidget {
  final String organizationId;
  const EditOrganizationInfoBottomSheet({
    super.key,
    required this.organizationId,
  });

  void _handleNameChanged(BuildContext context, String value) {
    context.read<EditOrganizationBloc>().add(OnNameChanged(value: value));
  }

  void _handleEmailChanged(BuildContext context, String value) {
    context.read<EditOrganizationBloc>().add(OnEmailChanged(value: value));
  }

  void _handlePhoneNumberChanged(BuildContext context, String value) {
    context
        .read<EditOrganizationBloc>()
        .add(OnPhoneNumberChanged(value: value));
  }

  void _handleUpdateOrganization(BuildContext context) {
    context.read<EditOrganizationBloc>().add(OnUpdateOrganization(
        organizationId: organizationId,
        onSuccess: () {
          context.pop();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
      builder: (context, state) {
        final organizationResult = state.organizationResult;
        final nameFieldInitialValue =
            (organizationResult is ApiResultSuccess<Organization>)
                ? organizationResult.data.name
                : '';
        final emailFieldInitialValue =
            (organizationResult is ApiResultSuccess<Organization>)
                ? organizationResult.data.email
                : '';
        final contactPhoneFieldInitialValue =
            (organizationResult is ApiResultSuccess<Organization>)
                ? organizationResult.data.contactPhoneNumber
                : '';

        return CustomDraggableSheet(
          initialChildSize: 0.95,
          child: Column(
            children: [
              const Text(
                "Organization Info",
                style: CustomFonts.labelMedium,
              ),
              12.kH,
              CustomOutlinedTextfield(
                label: 'Name',
                initialValue: nameFieldInitialValue,
                onChanged: (value) {
                  _handleNameChanged(context, value);
                },
              ),
              12.kH,
              CustomOutlinedTextfield(
                label: 'Email',
                initialValue: emailFieldInitialValue,
                onChanged: (value) {
                  _handleEmailChanged(context, value);
                },
                prefixIcon: const HeroIcon(
                  HeroIcons.envelope,
                  size: 18,
                ),
              ),
              12.kH,
              CustomOutlinedTextfield(
                label: 'Contact Phoone Number',
                initialValue: contactPhoneFieldInitialValue,
                onChanged: (value) {
                  _handlePhoneNumberChanged(context, value);
                },
                inputFormatters: [PhoneInputFormatter()],
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/malaysia-flag.png"),
                      4.kW,
                      const Text(
                        "+60",
                        style: CustomFonts.labelSmall,
                      )
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: state.isUpdatingOrganization,
                      enabled: !state.isUpdatingOrganization,
                      onPressed: () {
                        _handleUpdateOrganization(context);
                      },
                      child: Text("Save"),
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
