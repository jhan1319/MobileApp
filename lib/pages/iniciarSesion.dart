import 'package:flutter/material.dart';
import 'package:flutter_try_project/pages/vistaLogged.dart';
import 'package:http/http.dart' as saka;
//import 'package:geolocator/geolocator.dart';

// ignore: camel_case_types
class iniciarSesion extends StatefulWidget {
  iniciarSesion({Key key}) : super(key: key);

  @override
  _iniciarSesion createState() => _iniciarSesion();
}

// ignore: camel_case_types
class _iniciarSesion extends State<iniciarSesion> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar Sesión"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Usuario: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Username"),
              controller: userController,
            ),
          ),
          Text(
            "Password ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Password"),
              controller: passController,
            ),
          ),
          Divider(
            height: 50,
          ),
          confirmar(context),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          cancelar(context)
        ],
      ),
    );
  }

  Future loginRequest(String user, String password) async {
    final apiURL = Uri.parse("http://10.0.2.2:7006/Autenticar/app");

    final response =
        await saka.post(apiURL, body: {"name": user, "pass": password});

    if (response.statusCode == 201) {
      final responseString = response.body;
      print("LA RESPUESTA DE LA PETICIÓN ES: " + responseString);
      return responseString;
    } else {
      print("NULL EN LA RESPUESTA");
      return null;
    }
  }

  Widget confirmar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          final user = userController.text;
          final password = passController.text;
          loginRequest(user, password);
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Vistalogged()),
          );*/
        },
        child: Column(
          children: [
            Icon(
              Icons.login,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Iniciar Sesión",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Column(
          children: [
            Icon(
              Icons.cancel,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Cancelar",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
