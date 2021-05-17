import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teamupadmin/Screens/DashboardScreen.dart';
import 'package:teamupadmin/Screens/LoginScreen.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamUp Admin',
      theme: ThemeData(
        brightness:Brightness.light,
        primaryColor: Hexcolor('#2d63d7'),
        accentColor: Hexcolor('#9ac4ff'),
        accentColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),

          //headline1: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 20.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'TeamUp Admin'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void initState() {
    super.initState();
    Preference.init();
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
            Preference.getIsLogin() ? Dashboard() : Login())));

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Image.asset('assets/splashscreen/icon.png')
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
