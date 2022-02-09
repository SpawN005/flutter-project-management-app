import 'package:flutter/material.dart';
import 'connexion.dart';
import 'index.dart';
import 'report.dart';
import 'addReport.dart';
import 'updateReport.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurple,

        // Define the default font family.
        fontFamily: 'Raleway',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 25.0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => connexion(),
        '/index': (context) => index(),
        '/rapport': (context) => rapport(),
        '/addUser': (context) => addrapport(),
        '/update': (context) => UpdateUser(),
      },
    );
    throw UnimplementedError();
  }
}
