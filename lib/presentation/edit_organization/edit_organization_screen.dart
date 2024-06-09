import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/single_image_picker.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/common/widgets/text/gradient_text.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/widgets/edit_organization_image_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/widgets/edit_organization_info_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/widgets/invitation_code_bottom_sheet.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/widgets/organization_members_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class EditOrganizationScreen extends StatefulWidget {
  static const route = '/edit-organization/:organizationId';
  static generateRoute({
    required String organizationId,
    Organization? organization,
  }) =>
      '/edit-organization/$organizationId';
  final Organization? organization;
  final String organizationId;
  const EditOrganizationScreen({
    super.key,
    required this.organization,
    required this.organizationId,
  });

  @override
  State<EditOrganizationScreen> createState() => _EditOrganizationScreenState();
}

class _EditOrganizationScreenState extends State<EditOrganizationScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _contactPhoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _contactPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactPhoneController.dispose();
    super.dispose();
  }

  void _updateControllers(EditOrganizationState state) {
    if (state.organizationResult is ApiResultSuccess<Organization>) {
      final organization =
          (state.organizationResult as ApiResultSuccess<Organization>).data;
      _nameController.text = organization.name;
      _emailController.text = organization.email;
      _contactPhoneController.text = organization.contactPhoneNumber;
    }
  }

  void _handleOpenEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<EditOrganizationBloc>(context),
          child: EditOrganizationInfoBottomSheet(
            organizationId: widget.organizationId,
          ),
        );
      },
    );
  }

  void _handleOpenImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      isDismissible: true,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<EditOrganizationBloc>(context),
          child: EditOrganizationImageBottomSheet(
              organizationId: widget.organizationId),
        );
      },
    );
  }

  void _handleOpenMembersBottomSheet(BuildContext context) {
    context
        .read<EditOrganizationBloc>()
        .add(OnFetchOrganizationMembers(organizationId: widget.organizationId));
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<EditOrganizationBloc>(context),
          child: const OrganizationMembersBottomSheet(),
        );
      },
    );
  }

  void _handleOpenInvitationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<EditOrganizationBloc>(context),
          child: const InvitationCodeBottomSheet(),
        );
      },
    );
  }

  Widget _buildAppBarTitle(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      return Text(
        organizationResult.data.name,
        style: CustomFonts.labelMedium,
      );
    }
    return const Skeleton(
      height: Dimensions.loadingBodyHeight,
      width: 40,
    );
  }

  Widget _buildTeamMemberList(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      if (organizationResult.data.members != null &&
          organizationResult.data.members!.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: organizationResult.data.members!.length,
          itemBuilder: (context, index) {
            final user = organizationResult.data.members![index];
            return MemberItem(
              user: user,
            );
          },
        );
      }
      return const SizedBox();
    }
    return const Skeleton(
      height: Dimensions.loadingBodyHeight,
      width: 40,
    );
  }

  Widget _buildCreatorContent(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      return MemberItem(
        user: organizationResult.data.createdBy,
        isCreator: true,
      );
    }
    return const Skeleton(
      height: Dimensions.loadingBodyHeight,
      width: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditOrganizationBloc(
        fetchOrganization: serviceLocator(),
        fetchOrganizationMembers: serviceLocator(),
        updateOrganization: serviceLocator(),
      )..add(OnInitOrganization(
          organization: widget.organization,
          organizationId: widget.organizationId,
        )),
      child: BlocConsumer<EditOrganizationBloc, EditOrganizationState>(
        listener: (context, state) {
          final organizationResult = state.organizationResult;

          if (organizationResult is ApiResultFailure<Organization>) {
            toastification.show(
              type: ToastificationType.error,
              title: Text(
                  organizationResult.errorMessage ?? 'Something went wrong'),
            );
          }
        },
        builder: (context, state) {
          _updateControllers(state);
          final organizationResult = state.organizationResult;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: _buildAppBarTitle(state.organizationResult),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SingleImagePicker(
                        previewImageUrl: (organizationResult
                                is ApiResultSuccess<Organization>)
                            ? organizationResult.data.imageUrl
                            : null,
                        onPressed: () {
                          _handleOpenImageBottomSheet(context);
                        },
                      ),
                    ),
                    20.kH,
                    Row(
                      children: [
                        const Text(
                          "Organization Info",
                          style: CustomFonts.labelMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            _handleOpenEditBottomSheet(context);
                          },
                          child: Row(
                            children: [
                              HeroIcon(
                                HeroIcons.pencil,
                                size: 20,
                              ),
                              4.kW,
                              Text(
                                'Edit',
                                style: CustomFonts.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomOutlinedTextfield(
                      controller: _nameController,
                      readOnly: true,
                      label: 'Name',
                    ),
                    12.kH,
                    CustomOutlinedTextfield(
                      controller: _emailController,
                      readOnly: true,
                      label: 'Email',
                      prefixIcon: const HeroIcon(
                        HeroIcons.envelope,
                        size: 18,
                      ),
                    ),
                    12.kH,
                    CustomOutlinedTextfield(
                      controller: _contactPhoneController,
                      readOnly: true,
                      label: 'Contact Phoone Number',
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
                    24.kH,
                    const Text(
                      "Team members",
                      style: CustomFonts.labelMedium,
                    ),
                    12.kH,
                    GestureDetector(
                      onTap: () {
                        _handleOpenInvitationBottomSheet(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.containerBorderGrey,
                            ),
                            child: HeroIcon(
                              HeroIcons.plus,
                              size: 24,
                              color: Colors.black38,
                            ),
                          ),
                          8.kW,
                          Text(
                            "Invite new member",
                            style: CustomFonts.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    12.kH,
                    _buildCreatorContent(organizationResult),
                    _buildTeamMemberList(organizationResult),
                    12.kH,
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              _handleOpenMembersBottomSheet(context);
                            },
                            child: Text('See all'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  final bool isCreator;
  final UserModel user;
  final VoidCallback? onPressed;
  const MemberItem({
    super.key,
    this.onPressed,
    required this.user,
    this.isCreator = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar(
          imageUrl: user.profileImageUrl,
          placeholder: user.fullName[0],
          size: 45,
        ),
        8.kW,
        Text(
          user.fullName,
          style: CustomFonts.labelSmall,
        ),
        if (isCreator) 6.kW,
        if (isCreator)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const GradientText(
              text: 'Creator',
              style: CustomFonts.labelExtraSmall,
            ),
          ),
        const Spacer(),
        if (!isCreator)
          TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(CustomColors.alert),
              overlayColor: MaterialStateProperty.all(
                  CustomColors.alert.withOpacity(0.12)),
            ),
            child: Text(
              'Remove',
              style: CustomFonts.labelSmall.copyWith(color: CustomColors.alert),
            ),
          ),
      ],
    );
  }
}
