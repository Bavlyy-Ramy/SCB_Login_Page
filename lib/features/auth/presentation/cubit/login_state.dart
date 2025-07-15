part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {}
final class LoginFailure extends LoginState {
  final String erroMsg;
  LoginFailure(this.erroMsg);
}
class LoginOfflineLoading extends LoginState {}

