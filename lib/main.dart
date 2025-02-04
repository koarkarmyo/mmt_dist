import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/database/database_helper.dart';
import 'package:mmt_mobile/route/route_generate.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/ui/app_bloc_observer.dart';

void main() async {
  Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.instance.database;

    return MaterialApp(
      title: ConstString.appName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
