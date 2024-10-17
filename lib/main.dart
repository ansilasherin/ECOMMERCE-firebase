import 'package:dropflutter/widget/addtocart.dart';
import 'package:dropflutter/list/cartlist.dart';
import 'package:dropflutter/widget/dashbord.dart';
import 'package:dropflutter/sample/test1.dart';
import 'package:dropflutter/sample/test2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    // ChangeNotifierProvider(create: (_) => Wishlist()),
  ],
   child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: dropdown(),
    );
  }
}
