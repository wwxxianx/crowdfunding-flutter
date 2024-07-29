import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/user/profile/user_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/profile/user_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TaxInfoBottomSheet extends StatefulWidget {
  const TaxInfoBottomSheet({super.key});

  @override
  State<TaxInfoBottomSheet> createState() => _TaxInfoBottomSheetState();
}

class _TaxInfoBottomSheetState extends State<TaxInfoBottomSheet> {
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;
  late final TextEditingController identityNumberController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    identityNumberController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    identityNumberController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appUserState = context.read<AppUserCubit>().state;
    final currentUser = appUserState.currentUser;
    if (currentUser != null) {
      fullNameController.text = currentUser.fullName;
      phoneNumberController.text = currentUser.phoneNumber ?? "";
      addressController.text = currentUser.address ?? "";
      identityNumberController.text = currentUser.identityNumber ?? "";
    }
  }

  void _handleSubmit(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();
    final appUserCubit = context.read<AppUserCubit>();
    final fullName = fullNameController.text;
    final phoneNumber = phoneNumberController.text;
    final address = addressController.text;
    final identityNumber = identityNumberController.text;
    final payload = UserProfilePayload(
      address: address,
      fullName: fullName,
      phoneNumber: phoneNumber,
      identityNumber: identityNumber,
    );
    bloc.add(
      OnUpdateUserProfile(
        payload: payload,
        onSuccess: (user) {
          appUserCubit.updateUser(user);
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(updateUserProfile: serviceLocator()),
      child: Builder(
        builder: (context) {
          final userProfileState = context.watch<UserProfileBloc>().state;
          return CustomDraggableSheet(
            initialChildSize: 0.65,
            footer: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: CustomColors.containerBorderSlate,
                  ),
                ),
              ),
              child: CustomButton(
                isLoading: userProfileState.updateUserResult is ApiResultLoading,
                height: 42,
                style: CustomButtonStyle.black,
                onPressed: () {
                  _handleSubmit(context);
                },
                child: Text("Confirm"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomOutlinedTextfield(
                    label: "My full name",
                    controller: fullNameController,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    errorText: null,
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    label: "Phone number",
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
                    inputFormatters: [PhoneInputFormatter()],
                    keyboardType: TextInputType.phone,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    label: "Billing address",
                    controller: addressController,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    label: "NRIC / Passport No.",
                    controller: identityNumberController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
