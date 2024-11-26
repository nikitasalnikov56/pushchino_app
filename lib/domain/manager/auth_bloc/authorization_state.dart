
part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitial extends AuthorizationState {}

final class AuthorizationLoadedState extends AuthorizationState {

  final GetMeasuringDevices? getMeasuringDevices;
  final PersonalUserData? personalUserData;
  final BillingData? billingData;
  AuthorizationLoadedState({required this.getMeasuringDevices, required this.personalUserData, required this.billingData});
}

final class AuthorizationErrorState extends AuthorizationState {
  final String error;
  AuthorizationErrorState(this.error);
}
  // final TextEditingController login;
  // final TextEditingController password;
  // final BuildContext context;