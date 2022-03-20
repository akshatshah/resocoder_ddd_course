import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resocoder_ddd_course/presentation/sign_in/sign_in_page.dart';
import 'package:resocoder_ddd_course/presentation/splash/splash_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page',
  routes: <AutoRoute>[
    AutoRoute(
      page: SignInPage,
    ),
    AutoRoute(
      page: SplashPage,
      initial: true,
    )
  ],
  preferRelativeImports: false,
)
class AppRouter extends _$AppRouter {}
