import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:crowdfunding_flutter/state_management/account_scam_report/account_scam_report_bloc.dart';
import 'package:crowdfunding_flutter/state_management/account_scam_report/account_scam_report_event.dart';
import 'package:crowdfunding_flutter/state_management/account_scam_report/account_scam_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AccontScamReportScreen extends StatelessWidget {
  const AccontScamReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AccountScamReportBloc(fetchUserSubmittedScamReports: serviceLocator())
            ..add(OnFetchUserSubmittedScamReports()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Scam Report",
            style: CustomFonts.titleMedium,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AccountScamReportBloc, AccountScamReportState>(
          builder: (context, state) {
            final scamReportsResult = state.scamReportsResult;
            if (scamReportsResult is ApiResultLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (scamReportsResult is ApiResultSuccess<List<ScamReport>>) {
              if (scamReportsResult.data.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/empty-illustration.svg'),
                      16.kH,
                      Text(
                        "You don't have any report submitted",
                        style: CustomFonts.labelMedium,
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenHorizontalPadding),
                itemCount: scamReportsResult.data.length,
                itemBuilder: (context, index) {
                  final scamReport = scamReportsResult.data[index];
                  return ScamReportItem(
                    scamReport: scamReport,
                    onPressed: () {
                      context.push(
                          '/account/legality/scam-report/${scamReport.id}');
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ScamReportItem extends StatelessWidget {
  final ScamReport scamReport;
  final VoidCallback? onPressed;
  const ScamReportItem({
    super.key,
    required this.scamReport,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CustomColors.containerBorderSlate),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomChip(
              style: scamReport.statusEnum.chipStyle,
              child: Text(
                scamReport.statusEnum.displayTitle,
              ),
            ),
            8.kH,
            if (scamReport.resolution != null)
              Text(
                scamReport.resolution!,
                style: CustomFonts.labelSmall,
              ),
            8.kH,
            Text(
              "Your report:",
              style:
                  CustomFonts.bodySmall.copyWith(color: CustomColors.textGrey),
            ),
            Text(
              scamReport.description,
              style: CustomFonts.labelSmall,
              maxLines: 2,
            ),
            8.kH,
            if (scamReport.campaign != null)
              Text(
                scamReport.campaign!.title,
                style: CustomFonts.labelSmall
                    .copyWith(color: CustomColors.textGrey),
              ),
            12.kH,
            Text(
              scamReport.createdAt.toISODate(),
              style: CustomFonts.bodyExtraSmall.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
