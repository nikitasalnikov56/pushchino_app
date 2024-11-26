import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pushchino_app/domain/controllers/app_controllers.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/resources/app_images.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.blue,
      body: LoginAppBody(),
    );
  }
}

class LoginAppBody extends StatelessWidget {
  const LoginAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationLoadedState &&
            state.getMeasuringDevices != null) {
          context.go('/main');
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
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.loginBg),
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.logo),
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
                  onPressed: () {
                    context
                        .read<AuthorizationBloc>()
                        .add(AuthorizationLoadedEvent());
                   
                    // context.go('/main');
                  },
                  child: Text(
                    'ВХОД'.toUpperCase(),
                    style: AppStyle.fontStyle,
                  ),
                ),
              ],
            ),
          ),
        );
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
