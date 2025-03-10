import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_store/bloc/category/category_bloc.dart';
import 'package:ui_store/bloc/product/product_bloc.dart';
import 'package:ui_store/pages/dummyhomepage.dart';
import 'package:ui_store/pages/homepages.dart';
import 'package:ui_store/pages/sqlhome.dart';

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
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          '/': (context) => Dummyhomepage(),
          '/home': (context) => Homepages(),
          '/homeSQL': (context) => Sqlhome(),
        },
      ),
    );
  }
}
