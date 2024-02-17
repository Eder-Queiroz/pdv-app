import 'package:flutter/material.dart';
import 'package:pdv_app/pages/login_page.dart';
import 'package:pdv_app/pages/shift_page.dart';
import 'package:pdv_app/provider/shift_provider.dart';
import 'package:pdv_app/provider/user_provider.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:pdv_app/utils/colors_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ShiftProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'PDV',
        theme: ThemeData(
          primaryColor: ColorsTheme.primary500,
          colorScheme: const ColorScheme.light(
            primary: ColorsTheme.primary500,
            secondary: ColorsTheme.secondary500,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorsTheme.primary500,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.white,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            labelLarge: TextStyle(
              fontSize: 18,
              color: ColorsTheme.primary300,
            ),
          ),
        ),
        routes: {
          AppRouter.home: (ctx) => const LoginPage(),
          AppRouter.shift: (ctx) => const ShiftPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
