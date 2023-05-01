import 'package:flutter/material.dart';

import 'package:hive_database/hive/input_page.dart';
import 'package:hive_database/hive/poem_page.dart';
import 'package:hive_flutter/adapters.dart';

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Box box=await Hive.openBox("Country_list");
  Box namebox=await Hive.openBox("Writer_name");



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: InputPage(),
    );
  }
}

