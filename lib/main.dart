import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/product_bloc.dart';
import 'package:flutter_ecatalog/data/datasource/product_datasource.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';
import 'bloc/register/register_bloc.dart';
import 'presentation/register_page.dart';
import 'data/datasource/auth_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductDataSource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(ProductDataSource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const LoginPage(),
      ),
    );
  }
}
