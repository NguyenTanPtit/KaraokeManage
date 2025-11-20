part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}
class AuthLoginRequested extends AuthEvent {
  String credential;
  String password;

  AuthLoginRequested(this.credential, this.password);


}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}