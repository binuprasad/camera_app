

import 'package:camera_app2/model.dart';
import 'package:camera_app2/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(ImageModelAdapter().typeId)){
    Hive.registerAdapter(ImageModelAdapter());
  }

  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SplashScreen(),
    );
  }
}