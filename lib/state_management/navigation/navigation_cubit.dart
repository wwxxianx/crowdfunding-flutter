import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.home);

  void onNavigateTo(NavigationState route) {
    emit(route);
  }
}
