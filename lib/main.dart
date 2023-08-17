import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



/*CMD to perform deep linking*/
/* adb shell am start -W -a android.intent.action.VIEW -c android.intent.catego
ry.BROWSABLE -d "http://shrawanflutter.com/profile?username=JohnDoe" com.example.flutter_deeplinking
*/
void main() {
  runApp(MyApp());
}

GoRouter _appRoute = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const HomeScreen();
    },
  ),
  GoRoute(
    path: "/profile",
    builder: (BuildContext context, GoRouterState state) {
      final uri = Uri.parse(state.uri.toString());
      log("${uri.path}");
      final String? username = uri.queryParameters['username'];
      return Profile(username: username ?? "N/A");
    },
  ),

  GoRoute(
    path: "/help",
    builder: (BuildContext context, GoRouterState state) {
      return const Help();
    },
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRoute,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          context.go('/profile');
        }, child: Text("Move to profile screen")),
      ),
    );
  }
}
class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Help"),
      ),
    );
  }
}
class Profile extends StatelessWidget {
  const Profile({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile: $username"),
      ),
    );
  }
}