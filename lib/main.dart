import 'package:flutter/material.dart';
import 'package:flutter_try_project/pages/directEmergency.dart';
//import 'package:flutter_try_project/pages/LoggedEmergencia.dart';
//import 'package:flutter_try_project/pages/loggedView.dart';
import 'package:flutter_try_project/pages/iniciarSesion.dart';

void main() {
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp_Demo',
      theme: ThemeData(
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: homePage(),
    );
  }
}

// ignore: camel_case_types
class homePage extends StatefulWidget {
  homePage({Key key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://wallpaperaccess.com/full/1551100.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                  //ESTE BOTÓN ES PARA LOGEARSE EN EL APP
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => iniciarSesion()),
                    );
                  },
                  child: Center(
                    child: Text("Login"),
                  )),
            ),

            ////////////////////////////////
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(70)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => directEmergency()),
                    );
                  },
                  child: Center(child: Text("EMERGENCIA!!"))),
            )
          ],
        ),
      ),
    );
  }
}

Widget cuerpo() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            "https://images.hdqwalls.com/download/firewatch-sunset-artwork-3x-1080x2280.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          nombreApp(),
          SizedBox(
            height: 40,
          ),
          loginButton(),
          SizedBox(
            height: 100,
          ),
          //emergencyButton()
        ],
      ),
    ),
  );
}

Widget nombreApp() {
  return Text(
    "Sistema Inteligente de emergenciasss",
    style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget loginButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
    child: ElevatedButton(
        onPressed: () {}, child: Center(child: Text("Login as User"))),
  );
}
