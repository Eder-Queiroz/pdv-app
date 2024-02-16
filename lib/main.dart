import 'package:flutter/material.dart';
import 'package:pdv_app/data/user_data.dart';
import 'package:pdv_app/screens/product_screen.dart';
import 'package:pdv_app/screens/sale_screen.dart';
import 'package:pdv_app/screens/shift_screen.dart';
import 'package:pdv_app/screens/show_shift_screen.dart';
import 'package:pdv_app/screens/users_screen.dart';
import 'package:pdv_app/utils/app_router.dart';
import './data/shifts_data.dart';
import './data/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.white,
        ),
      ),
      initialRoute: AppRouter.home,
      routes: {
        AppRouter.home: (_) => ShiftScreen(shiftsData: shiftsData),
        AppRouter.showShift: (_) => const ShowShiftScreen(),
        AppRouter.product: (_) => ProductScreen(productsData: productData),
        AppRouter.sales: (_) => const SaleScreen(),
        AppRouter.users: (_) => UsersScreen(usersData: usersData),
      },
    );
  }
}
