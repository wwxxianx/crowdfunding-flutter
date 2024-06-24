import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/state_management/user_community_challenge/user_community_challenge_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

final supabase = Supabase.instance.client;

class _TestScreenState extends State<TestScreen> {
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCommunityChallengeBloc(supabase: serviceLocator()),
      child:
          BlocListener<UserCommunityChallengeBloc, UserCommunityChallengeState>(
        listenWhen: (previous, current) {
          return previous.data != current.data;
        },
        listener: (context, state) {
          if (state.data.isNotEmpty) {
            toastification.show(
              title: Text('New message coming in'),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Text('Testing'),
                CustomButton(
                    onPressed: () {
                      toastification.show(
                        title: Text('New message come in'),
                      );
                    },
                    child: Text('Print')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
