import 'package:flutter/material.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/components/left_card.dart';
import 'package:pushchino_app/ui/components/right_card.dart';

class RowInfoCards extends StatelessWidget {
  const RowInfoCards({super.key, required this.state});
  final AuthorizationLoadedState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LeftCard(state: state),
        RightCard(state: state),
      ],
    );
  }
}
