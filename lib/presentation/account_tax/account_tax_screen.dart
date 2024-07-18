import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_event.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountTaxScreen extends StatelessWidget {
  static const route = "/account/tax-receipt";
  const AccountTaxScreen({super.key});

  Widget _buildContent(BuildContext context) {
    final bloc = context.read<UserDonationsBloc>();
    final userDonationsResult = bloc.state.userDonationsResult;
    if (userDonationsResult is ApiResultSuccess<List<CampaignDonation>>) {
      if (userDonationsResult.data.isEmpty) {
        return Text("Empty");
      }
      final donationsGroupByYear =
          userDonationsResult.data.groupDonationsByYear();
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding),
        child: Column(
          children: donationsGroupByYear.entries.map((e) {
            return GestureDetector(
              onTap: () {
                bloc.add(
                  OnFetchTaxReceipt(
                    year: e.key,
                    onSuccess: (data) async {
                      if (!await launchUrl(Uri.parse(data.receiptFileUrl))) {
                        context.showSnackBar('Failed to open receipt file');
                      }
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: double.maxFinite,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CustomColors.containerBorderGrey,
                    width: 1,
                  ),
                  boxShadow: CustomColors.containerSlateShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${e.key} Donations Receipt",
                        style: CustomFonts.labelMedium),
                    6.kW,
                    HeroIcon(
                      HeroIcons.arrowDownTray,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
    if (userDonationsResult is ApiResultLoading) {
      return CircularProgressIndicator();
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDonationsBloc(
        fetchUserDonations: serviceLocator(),
        fetchTaxReceipt: serviceLocator(),
      )..add(OnFetchUserDonations()),
      child: BlocBuilder<UserDonationsBloc, UserDonationsState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Tax Receipts",
                    style: CustomFonts.titleMedium,
                  ),
                  centerTitle: true,
                ),
                body: _buildContent(context),
              ),
              if (state.taxReceiptResult is ApiResultLoading) ScaffoldMask(isLoading: state.taxReceiptResult is ApiResultLoading,),
            ],
          );
        },
      ),
    );
  }
}
