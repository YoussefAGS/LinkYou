import 'package:flutter/material.dart';
import 'package:linkyou/features/home/presentation/screens/user_list.dart';
import '../../features/auth/presentation/screens/login.dart';
import '../common/screens/underplid.dart';
import 'basi_route.dart';

class AppRoute{
  static const String login="login";
  static const String home="home";


  static Route<void> routes(RouteSettings routeSettings){
  // final argu= routeSettings.arguments;
  switch(routeSettings.name){
    case login:return BaseRoute(page:  Login());
    case home:return BaseRoute(page:  UsersList());
    default :
      return BaseRoute(page:  PageUnderBuildScreen());
  }
}
}