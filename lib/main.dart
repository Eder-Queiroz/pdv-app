import 'package:flutter/material.dart';
import 'package:pdv_app/pages/cashier_page.dart';
import 'package:pdv_app/pages/cashier_payment_page.dart';
import 'package:pdv_app/pages/login_page.dart';
import 'package:pdv_app/pages/product_form_page.dart';
import 'package:pdv_app/pages/product_page.dart';
import 'package:pdv_app/pages/sale_page.dart';
import 'package:pdv_app/pages/shift_page.dart';
import 'package:pdv_app/pages/shift_details_page.dart';
import 'package:pdv_app/pages/supplier_form_page.dart';
import 'package:pdv_app/pages/supplier_page.dart';
import 'package:pdv_app/pages/taker_page.dart';
import 'package:pdv_app/pages/user_page.dart';
import 'package:pdv_app/provider/cashier_provider.dart';
import 'package:pdv_app/provider/category_provider.dart';
import 'package:pdv_app/provider/order_provider.dart';
import 'package:pdv_app/provider/product_provider.dart';
import 'package:pdv_app/provider/shift_provider.dart';
import 'package:pdv_app/provider/supplier_provider.dart';
import 'package:pdv_app/provider/taker_provider.dart';
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
        ChangeNotifierProvider(create: (_) => ShiftProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => TakerProvider()),
        ChangeNotifierProvider(create: (_) => CashierProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'PDV',
        theme: ThemeData(
          primaryColor: ColorsTheme.primary500,
          colorScheme: const ColorScheme.light(
            primary: ColorsTheme.primary500,
            secondary: ColorsTheme.secondary500,
          ),
          scaffoldBackgroundColor: ColorsTheme.primary800,
          drawerTheme: const DrawerThemeData(
            backgroundColor: ColorsTheme.primary800,
            elevation: 10,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorsTheme.primary500,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
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
          AppRouter.shiftDetails: (_) => const ShiftDetailsPage(),
          AppRouter.home: (_) => const LoginPage(),
          AppRouter.shift: (_) => const ShiftPage(),
          AppRouter.supplier: (_) => const SupplierPage(),
          AppRouter.supplierForm: (_) => const SupplierFormPage(),
          AppRouter.product: (_) => const ProductPage(),
          AppRouter.productForm: (_) => const ProductFormPage(),
          AppRouter.user: (_) => const UserPage(),
          AppRouter.taker: (_) => const TakerPage(),
          AppRouter.cashier: (_) => const CashierPage(),
          AppRouter.cashierPayment: (_) => const CashierPaymentPage(),
          AppRouter.sale: (_) => const SalePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
