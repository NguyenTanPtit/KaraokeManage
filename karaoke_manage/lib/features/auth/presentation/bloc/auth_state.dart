import 'package:karaoke_manage/features/auth/domain/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final AppUser user;

  AuthAuthenticatedState(this.user);
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}

class AuthLoggedOutState extends AuthState {}