import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/scam_report/fetch_user_submitted_scam_reports.dart';
import 'package:crowdfunding_flutter/state_management/account_scam_report/account_scam_report_event.dart';
import 'package:crowdfunding_flutter/state_management/account_scam_report/account_scam_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScamReportBloc
    extends Bloc<AccountScamReportEvent, AccountScamReportState> {
  final FetchUserSubmittedScamReports _fetchUserSubmittedScamReports;
  AccountScamReportBloc({
    required FetchUserSubmittedScamReports fetchUserSubmittedScamReports,
  })  : _fetchUserSubmittedScamReports = fetchUserSubmittedScamReports,
        super(const AccountScamReportState.initial()) {
    on<AccountScamReportEvent>(_onEvent);
  }

  Future<void> _onEvent(
    AccountScamReportEvent event,
    Emitter<AccountScamReportState> emit,
  ) async {
    return switch (event) {
      final OnFetchUserSubmittedScamReports e =>
        _onFetchUserSubmittedScamReports(e, emit),
    };
  }

  Future<void> _onFetchUserSubmittedScamReports(
    OnFetchUserSubmittedScamReports event,
    Emitter<AccountScamReportState> emit,
  ) async {
    emit(state.copyWith(scamReportsResult: const ApiResultLoading()));
    final res = await _fetchUserSubmittedScamReports.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          scamReportsResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(scamReportsResult: ApiResultSuccess(data))),
    );
  }
}
