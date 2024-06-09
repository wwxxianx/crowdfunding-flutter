import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/single_image_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditOrganizationImageBottomSheet extends StatelessWidget {
  final String organizationId;
  const EditOrganizationImageBottomSheet({
    super.key,
    required this.organizationId,
  });

  void _handleUpdateOrganization(BuildContext context) {
    context.read<EditOrganizationBloc>().add(OnUpdateOrganization(
        onSuccess: () {
          context.pop();
        },
        organizationId: organizationId));
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: BlocBuilder<EditOrganizationBloc, EditOrganizationState>(
        builder: (context, state) {
          final organizationResult = state.organizationResult;
          return Column(
            children: [
              const Text(
                'Upload Organization Image',
                style: CustomFonts.labelMedium,
              ),
              20.kH,
              SingleImagePicker(
                previewImageUrl:
                    organizationResult is ApiResultSuccess<Organization>
                        ? organizationResult.data.imageUrl
                        : null,
                onFileChanged: (file) {
                  context
                      .read<EditOrganizationBloc>()
                      .add(OnImageFileChanged(file: file));
                },
              ),
              24.kH,
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
              )
            ],
          );
        },
      ),
    );
  }
}
