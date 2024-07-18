import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/organization_profile_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrganizationRedirectScreen extends StatelessWidget {
  static const route = '/redirect/organization';
  const OrganizationRedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      bloc: serviceLocator<AppUserCubit>()..fetchCurrentUserProfile(),
      listener: (context, state) {
        final userProfileResult = state.userProfileResult;
        if (userProfileResult is ApiResultSuccess<UserModel>) {
          if (userProfileResult.data.organization != null) {
            context.go(OrganizationProfileScreen.generateRoute(
                organizationId: userProfileResult.data.organization!.id));
            return;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
