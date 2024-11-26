import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/routes/app_router.dart';

class PushchinoApp extends StatelessWidget {
  const PushchinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorizationBloc(context),
      child: MaterialApp.router(
        // debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
