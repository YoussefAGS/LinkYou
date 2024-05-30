import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'core/app/connectivity_controller.dart';
import 'core/common/screens/network_conniction.dart';
import 'core/routes/app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeYou extends StatelessWidget {
  const LikeYou({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, __) {
        if (value) {
          return ScreenUtilInit(
            designSize: const Size(375, 810),
            minTextAdapt: true,
            child:  MaterialApp(
              theme:ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              locale: Locale('en'),
              title: 'Link You',
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Scaffold(
                    body: Builder(
                      builder: (context) {
                        ConnectivityController.instance.init();
                        return widget!;
                      },
                    ),
                  ),
                );
              },
              onGenerateRoute: AppRoute.routes,
              initialRoute: FirebaseAuth.instance.currentUser != null ? AppRoute.home : AppRoute.login,
            ),
          );
        } else {
          return MaterialApp(
              title: 'Link You',
              debugShowCheckedModeBanner: false,
              home: NoNetWorkScreen());
        }
      },
    );
  }
}