import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupBankAccountBottomSheet extends StatelessWidget {
  const SetupBankAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.95,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/bank-transfer.svg'),
                    4.kW,
                    const Text(
                      "Setup Your Back Account",
                      style: CustomFonts.labelSmall,
                    ),
                  ],
                ),
                6.kH,
                const Text(
                  'Before you receive any donation, please set up a valid bank account in order to receive donation.',
                  style: CustomFonts.bodySmall,
                )
              ],
            ),
            20.kH,
            SvgPicture.asset('assets/images/setup-stripe-connect-account.svg'),
            30.kH,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      context
                          .read<AppUserCubit>()
                          .connectStripeAccount((onboardLink) async {
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
                      });
                    },
                    child: Text('Setup my bank account'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
