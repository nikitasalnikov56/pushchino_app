part of 'bottom_navbar_bloc.dart';

@immutable
sealed class BottomNavbarEvent {}

final class BottomNavbarLoadEvent extends BottomNavbarEvent{
  final int index;

   BottomNavbarLoadEvent({required this.index});
}