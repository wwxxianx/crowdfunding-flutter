import 'package:flutter/material.dart';

@immutable
sealed class AccountScamReportEvent {
  const AccountScamReportEvent();
}

final class OnFetchUserSubmittedScamReports extends AccountScamReportEvent {}