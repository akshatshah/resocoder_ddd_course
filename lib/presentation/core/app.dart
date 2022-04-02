import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resocoder_ddd_course/application/auth/auth_bloc.dart';
import 'package:resocoder_ddd_course/injection.dart';
import 'package:resocoder_ddd_course/presentation/sign_in/sign_in_page.dart';
import 'package:resocoder_ddd_course/presentation/routes/router.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(
              const AuthEvent.authCheckRequested(),
            ),
        )
      ],
      child: MaterialApp.router(
        title: 'Notes',
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData.light().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
          ),
          primaryColor: Colors.green.shade800,
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.green.shade800,
            secondary: Colors.blueAccent,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade800,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
