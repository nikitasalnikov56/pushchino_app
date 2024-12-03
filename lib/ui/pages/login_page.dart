import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pushchino_app/domain/controllers/app_controllers.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/resources/app_images.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const LoginAppBody().autoLogin(context);
    });

    return const Scaffold(
      backgroundColor: AppColors.blue,
      body: LoginAppBody(),
    );
  }
}

class LoginAppBody extends StatelessWidget {
  const LoginAppBody({super.key});
  Future<void> saveCredentials(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login', login);
    await prefs.setString('password', password);
  }

  Future<Map<String, String?>> getCredentials() async {
    final pref = await SharedPreferences.getInstance();
    return {
      'login': pref.getString('login'),
      'password': pref.getString('password'),
    };
  }

  Future<void> autoLogin(BuildContext context) async {
    final credentials = await getCredentials();
    final login = credentials['login'];
    final password = credentials['password'];

    if (login != null && password != null) {
      AppControllers.login.text = login;
      AppControllers.password.text = password;
      if (context.mounted) {
        context.read<AuthorizationBloc>().add(AuthorizationLoadedEvent());
      }
    } else {
      if (context.mounted) {
        context.read<AuthorizationBloc>().add(AuthorizationShowFormEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) async {
        if (state is AuthorizationLoadedState &&
            state.getMeasuringDevices != null) {
          await saveCredentials(
            AppControllers.login.text,
            AppControllers.password.text,
          );
          if (context.mounted) {
            context.go('/main');
          }
        } else if (state is AuthorizationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthorizationInitial || state is AuthorizationLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AuthorizationShowFormState ||
            state is AuthorizationErrorState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  ImagesList.listImages[
                      Random().nextInt(ImagesList.listImages.length)],
                ),
              ),
            ),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 270, child: Image.asset(AppImages.logo)),
                  const SizedBox(height: 153),
                  Form(
                    child: TextFieldWidget(
                      hintText: 'ЛОГИН'.toUpperCase(),
                      controller: AppControllers.login,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    child: TextFieldWidget(
                      hintText: 'ПАРОЛЬ'.toUpperCase(),
                      controller: AppControllers.password,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 29),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: state is! AuthorizationLoadingState
                        ? () {
                            context
                                .read<AuthorizationBloc>()
                                .add(AuthorizationLoadedEvent());
                          }
                        : null,
                    // () {

                    //   // context
                    //   //     .read<AuthorizationBloc>()
                    //   //     .add(AuthorizationLoadedEvent());

                    //   // context.go('/main');
                    // },
                    child:Text(
                            'ВХОД'.toUpperCase(),
                            style: AppStyle.fontStyle,
                          ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: AppColors.lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: hintText,
          hintStyle: AppStyle.fontStyle.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}
