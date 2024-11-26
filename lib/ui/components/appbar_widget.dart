import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/resources/app_icons.dart';
import 'package:pushchino_app/ui/resources/app_images.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        final newState = state is AuthorizationLoadedState ? state : null;
        return Padding(
          padding: const EdgeInsets.only(top: 50, left: 26, right: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SizedBox(
                  width: 30,
                  height: 17,
                  child: SvgPicture.asset(
                    AppIcons.menu,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  titleAlignment: ListTileTitleAlignment.top,
                  title: Text(
                    '${newState?.personalUserData?.returnPersonalUserData?.personalData?.name}',
                    textAlign: TextAlign.end,
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    'ID: ${newState?.personalUserData?.returnPersonalUserData?.personalData?.personalAccount}',
                    textAlign: TextAlign.end,
                    style: AppStyle.fontStyle.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 31.5,
                    child: Image.asset(AppImages.user),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 135);
}
