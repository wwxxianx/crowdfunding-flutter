import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:equatable/equatable.dart';

final class AccountScamReportState extends Equatable {
  final ApiResult<List<ScamReport>> scamReportsResult;

  const AccountScamReportState({
    required this.scamReportsResult,
  });

  const AccountScamReportState.initial()
      : this(scamReportsResult: const ApiResultInitial());

  AccountScamReportState copyWith({
    ApiResult<List<ScamReport>>? scamReportsResult,
  }) {
    return AccountScamReportState(
      scamReportsResult: scamReportsResult ?? this.scamReportsResult,
    );
  }

  @override
  List<Object> get props => [scamReportsResult];
}
