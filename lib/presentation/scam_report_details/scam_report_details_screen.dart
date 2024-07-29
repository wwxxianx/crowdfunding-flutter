import 'package:flutter/material.dart';

class ScamReportDetailsScreen extends StatelessWidget {
  final String scamReportId;
  const ScamReportDetailsScreen({
    super.key,
    required this.scamReportId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
          ),
        ),
      ),
    );
  }
}
