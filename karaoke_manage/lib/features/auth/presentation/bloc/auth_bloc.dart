import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:karaoke_manage/features/auth/data/auth_repo.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/locator.dart';


part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository _authRepository = locator<AuthRepository>();

  AuthBloc() : super(AuthInitialState()){
    on<AuthLoginRequested>((event, emit) async {
      await _onAuthEvent(event, emit);
    });

    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoadingState());
      try{
        await _authRepository.signOut();
        emit(AuthLoggedOutState());
      }catch(e){
        log(e.toString());
        emit(AuthErrorState('Cannot logout at the moment'));
      }
    });

    on<AuthCheckStatus>((event, emit) async {
      await _onCheckStatusEvent(event, emit);
    });
  }

  Future<void> _onAuthEvent(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try{
      final user = await _authRepository.signIn(
        credential: event.credential,
        password: event.password,
      );
      emit(AuthAuthenticatedState(user));

    }catch(e){
      log(e.toString());
      emit(AuthErrorState('Cannot login with provided credentials'));
    }
  }

  Future<void> _onCheckStatusEvent(AuthCheckStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await _authRepository.getCurrentUser();

      if (user != null) {
        emit(AuthAuthenticatedState(user));
      } else {
        emit(AuthLoggedOutState());
      }

    } catch (e) {
      emit(AuthErrorState("Cannot check authentication status"));
    }
  }

}