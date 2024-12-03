part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationEvent {}

final class AuthorizationLoadedEvent extends AuthorizationEvent {}
final class AuthorizationShowFormEvent extends AuthorizationEvent {}
class AuthorizationLogoutEvent extends AuthorizationEvent {}

