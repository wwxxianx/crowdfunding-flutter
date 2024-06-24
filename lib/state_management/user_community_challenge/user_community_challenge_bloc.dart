import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class UserCommunityChallengeState extends Equatable {
  final List<Map<String, dynamic>> data;
  const UserCommunityChallengeState._({
    this.data = const [],
  });

  const UserCommunityChallengeState.initial() : this._();

  UserCommunityChallengeState copyWith({
    List<Map<String, dynamic>>? data,
  }) {
    return UserCommunityChallengeState._(data: data ?? this.data);
  }

  @override
  List<Object?> get props => [data.hashCode];
}

@immutable
sealed class UserCommunityChallengeEvent {
  const UserCommunityChallengeEvent();
}

final class OnListenTableChanged extends UserCommunityChallengeEvent {
  final List<Map<String, dynamic>> data;

  const OnListenTableChanged({required this.data});
}

class UserCommunityChallengeBloc
    extends Bloc<UserCommunityChallengeEvent, UserCommunityChallengeState> {
  final SupabaseClient _supabase;
  
  final logger = Logger();

  UserCommunityChallengeBloc({
    required SupabaseClient supabase,
  })  : _supabase = supabase,
        super(const UserCommunityChallengeState.initial()) {
    final User? currentUser = supabase.auth.currentUser;
    final currentUserId = currentUser?.id ?? "";
    _supabase
      .from('campaign_donations')
      .stream(primaryKey: ['id'])
      .eq('userId', currentUserId)
      .listen(
        (data) {
          add(OnListenTableChanged(data: data));
        },
      );
    on<UserCommunityChallengeEvent>(_onEvent);
  }

  Future<void> _onEvent(
    UserCommunityChallengeEvent event,
    Emitter<UserCommunityChallengeState> emit,
  ) async {
    return switch (event) {
      final OnListenTableChanged e => _onListenTableChanged(e, emit),
    };
  }

  void _onListenTableChanged(
    OnListenTableChanged event,
    Emitter<UserCommunityChallengeState> emit,
  ) {
    emit(state.copyWith(data: event.data));
    // 1. Check completed community challenge
    // 2. If have, show toast message
  }
}
