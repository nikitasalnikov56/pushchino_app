part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationEvent {}

final class AuthorizationLoadedEvent extends AuthorizationEvent {}
