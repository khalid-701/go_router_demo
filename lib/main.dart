import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/about_page.dart';
import 'package:go_router_demo/edit_profile_page.dart';
import 'package:go_router_demo/login_page.dart';
import 'package:go_router_demo/main_page.dart';
import 'package:go_router_demo/profile_page.dart';
import 'package:go_router_demo/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        name: 'main_page',
        builder: (context, state) {
          return const MainPage();
        },
        routes: [
          GoRoute(
            path: 'profile/:name',
            name: 'profile',
            builder: (context, state){
              String name = state.pathParameters['name'] ?? "no name";
              return ProfilePage(name: name);
            } ,
            routes: [
              GoRoute(
                path: 'edit_profile',
                name: 'edit_profile',
                builder: (context, state) {

                  Object? obj =  state.extra;
                  if(obj != null && obj is User) {
                    return  EditProfilePage(user: obj);
                  } else {
                    return  EditProfilePage(user: User('no name', 'no email'));
                  }
                },
              ),
            ]
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (context, state) => const AboutPage(),
          ),
        ]
      )
    ],
    initialLocation: '/login',
    routerNeglect: true,
    debugLogDiagnostics: true,
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
