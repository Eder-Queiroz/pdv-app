import 'package:flutter/material.dart';
import 'package:pdv_app/pages/shift_page.dart';
import 'package:pdv_app/pages/shift_details_page.dart';
import 'package:pdv_app/provider/shift_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primaryColor: Colors.green,
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
        ),
        routes: {
          AppRouter.home: (ctx) => const ShiftPage(),
          AppRouter.shiftDetails: (ctx) => const ShiftDetailsPage(),
        },
      ),
    );
  }
}
