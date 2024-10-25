import 'package:flutter/material.dart';
import 'package:mmt_mobile/database/database_helper.dart';
import 'package:mmt_mobile/route/route_generate.dart';
import 'package:mmt_mobile/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.instance.database;

    return MaterialApp(
      title: 'MMT',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

