import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/domain/manager/get_print_form_data/get_print_form_data_bloc.dart';
import 'package:pushchino_app/ui/components/get_print_form_data_button.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPrintFormDataBloc(),
      child: Drawer(
        backgroundColor: AppColors.blue,
        child: Column(
          children: [
            const Spacer(),
            const GetPrintFormDataButton(),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.smokeBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                ),
                onPressed: () {
                  context
                      .read<AuthorizationBloc>()
                      .add(AuthorizationLogoutEvent());
                  context.go('/');
                },
                child: const Text(
                  'Выход',
                  style: AppStyle.fontStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
