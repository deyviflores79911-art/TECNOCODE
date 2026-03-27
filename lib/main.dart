import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/products/data/repositories/product_repository_impl.dart';
import 'src/features/products/presentation/providers/product_provider.dart';
import 'src/features/cart/presentation/providers/cart_provider.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/presentation/providers/auth_provider.dart';
import 'src/features/orders/presentation/providers/order_provider.dart';
import 'src/features/products/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(ProductRepositoryImpl())..fetchProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Cell Phone Sales',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
