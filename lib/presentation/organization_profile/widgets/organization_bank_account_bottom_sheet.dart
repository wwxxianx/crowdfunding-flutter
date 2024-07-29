import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_bloc.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_event.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_state.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationBankAccuontBottomSheet extends StatelessWidget {
  final String? connectedAccountId;
  const OrganizationBankAccuontBottomSheet({
    super.key,
    required this.connectedAccountId,
  });

  void _handleConnectAccount(BuildContext context) {
    context
        .read<OrganizationProfileBloc>()
        .add(OnConnectOrganizationBankAccount(
      onSuccess: (accountLink) async {
        if (!await launchUrl(Uri.parse(accountLink))) {
          // Error open link
          toastification.show(
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
            title: const Text("Failed to open link"),
          );
        }
      },
    ));
  }

  Widget _buildNoAccountCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.red100, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/x-circle-outlined.svg'),
              6.kW,
              Text(
                'No Account',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          Text(
            "You haven’t connect any bank account to your campaign.",
            style: CustomFonts.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildNotCompletedCard(StripeAccount stripeAccount) {
    List<String> errorList =
        stripeAccount.requirements?.errors?.isNotEmpty == true
            ? stripeAccount.requirements!.errors!
                .map((e) => e.reason ?? 'Infomation required')
                .toList()
            : [''];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.amber100, borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/checklist.svg'),
              6.kW,
              Text(
                'Information Not Completed',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          if (errorList.isNotEmpty)
            ...errorList.map((error) {
              return Text(
                error,
                style: CustomFonts.bodySmall,
              );
            }).toList(),
          if (errorList.isEmpty)
            Text(
              "Your bank account information is not completed.",
              style: CustomFonts.bodySmall,
            ),
        ],
      ),
    );
  }

  Widget _buildVerifiedCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.containerLightGreen,
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/shield-check-filled.svg'),
              6.kW,
              Text(
                'Verified and Completed',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          Text(
            "Your bank account is verified and ready to collect funds.",
            style: CustomFonts.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (connectedAccountId == null || connectedAccountId?.isEmpty == true) {
      // No account
      return Column(
        children: [
          const Text(
            'Connected Stripe Bank Account Status:',
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildNoAccountCard(),
        ],
      );
    }
    final stripeAccountResult =
        context.read<ConnectedAccountBloc>().state.stripeAccountResult;
    if (stripeAccountResult is ApiResultSuccess<StripeAccount>) {
      if (!stripeAccountResult.data.detailsSubmitted ||
          !stripeAccountResult.data.payoutsEnabled) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Connected Stripe Bank Account Status:',
              style: CustomFonts.labelMedium,
            ),
            8.kH,
            _buildNotCompletedCard(stripeAccountResult.data),
          ],
        );
      }
      // Verified
      return Column(
        children: [
          const Text(
            'Connected Stripe Bank Account Status:',
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildVerifiedCard(),
        ],
      );
    }
    // Loading
    return Column(
      children: [
        Text('Loading...'),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final stripeAccountResult =
        context.read<ConnectedAccountBloc>().state.stripeAccountResult;
    // No account
    if (connectedAccountId == null || connectedAccountId?.isEmpty == true) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
        decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: CustomColors.containerBorderSlate))),
        width: double.maxFinite,
        child: CustomButton(
          onPressed: () {
            _handleConnectAccount(context);
          },
          child: const Text("Set up organization bank account"),
        ),
      );
    }
    if (stripeAccountResult is ApiResultSuccess<StripeAccount>) {
      if (!stripeAccountResult.data.detailsSubmitted ||
          !stripeAccountResult.data.payoutsEnabled) {
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal:
                      BorderSide(color: CustomColors.containerBorderSlate))),
          width: double.maxFinite,
          child: CustomButton(
            onPressed: () {
              _handleConnectAccount(context);
            },
            child: Text("Finish set up organization bank account"),
          ),
        );
      }
      // Verified account
      return const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ConnectedAccountBloc(
          fetchConnectedAccount: serviceLocator(),
          updateConnectAccount: serviceLocator(),
        )..add(OnFetchConnectedAccount(
            stripeConnectAccountId: connectedAccountId));
      },
      child: BlocBuilder<ConnectedAccountBloc, ConnectedAccountState>(
        builder: (context, state) {
          return CustomDraggableSheet(
            initialChildSize: 0.6,
            footer: _buildFooter(context),
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.screenHorizontalPadding,
                right: Dimensions.screenHorizontalPadding,
                bottom: Dimensions.screenHorizontalPadding,
              ),
              child: _buildContent(context),
            ),
          );
        },
      ),
    );
  }
}
