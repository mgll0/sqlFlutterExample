import 'package:flutter/material.dart';
import 'home.dart';
import 'dataBase.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();  //Inicializa los widgets
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Home(),
    );
  }
}

