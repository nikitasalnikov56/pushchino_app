part of 'bottom_navbar_bloc.dart';

@immutable
sealed class BottomNavbarState {}

final class BottomNavbarInitial extends BottomNavbarState {}
final class BottomNavbarLoadState extends BottomNavbarState {

  final int index;

  BottomNavbarLoadState({required this.index});
}
