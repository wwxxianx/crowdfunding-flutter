import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/setup_bank_account_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_bloc.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_event.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectedBankAccountScreen extends StatelessWidget {
  final String? connectedAccountId;
  const ConnectedBankAccountScreen({
    super.key,
    this.connectedAccountId,
  });

  void _showConnectAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      isDismissible: true,
      context: context,
      builder: (modalContext) {
        return SetupBankAccountBottomSheet();
      },
    );
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
    if (connectedAccountId == null) {
      // No account
      return Column(
        children: [
          const Text(
            'Connected Stripe Bank Account Status:',
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildNoAccountCard(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    _showConnectAccountBottomSheet(context);
                  },
                  child: const Text("Set up my bank account"),
                ),
              ),
            ],
          )
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
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      context
                          .read<ConnectedAccountBloc>()
                          .add(OnUpdateConnectAccount(
                            stripeConnectAccountId: connectedAccountId ?? '',
                            onSuccess: (onboardLink) async {
                              final url = Uri.parse(onboardLink);
                              if (!await launchUrl(url)) {
                                toastification.show(
                                  type: ToastificationType.error,
                                  title: Text(
                                    "Failed to connect to Stripe",
                                    style: CustomFonts.labelSmall,
                                  ),
                                  description: Text(
                                    "Please try again later.",
                                    style: CustomFonts.bodySmall,
                                  ),
                                );
                              }
                            },
                          ));
                    },
                    child: Text("Finish set up my bank account"),
                  ),
                ),
              ],
            ),
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
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/bank-transfer.svg'),
                  4.kW,
                  const Text(
                    'Connected Bank Account',
                    style: CustomFonts.labelMedium,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.screenHorizontalPadding,
                right: Dimensions.screenHorizontalPadding,
                bottom: Dimensions.screenHorizontalPadding,
              ),
              child: _buildContent(context),
            ),
            // body: LayoutBuilder(
            //   builder: (context, constraints) {
            //     return SingleChildScrollView(
            //       child: ConstrainedBox(
            //         constraints:
            //             BoxConstraints(minHeight: constraints.maxHeight),
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //             left: Dimensions.screenHorizontalPadding,
            //             right: Dimensions.screenHorizontalPadding,
            //             bottom: Dimensions.screenHorizontalPadding,
            //           ),
            //           child: _buildContent(context),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          );
        },
      ),
    );
  }
}
