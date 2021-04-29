import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:flutter_try_project/main.dart';

import 'package:flutter_try_project/pages/vistaLogged.dart';
import 'package:http/http.dart' as saka;

import '../main.dart';

//import 'package:geolocator/geolocator.dart';

// ignore: camel_case_types
class iniciarSesion extends StatefulWidget {
  iniciarSesion({Key key}) : super(key: key);

  @override
  _iniciarSesion createState() => _iniciarSesion();
}

// ignore: camel_case_types
class _iniciarSesion extends State<iniciarSesion> {
  DataLogged userData;
  bool log = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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

  DataLogged data(DataLogged user) {
    userData = user;
    return userData;
  }

  Future loginRequest(String user, String password) async {
    final apiURL = Uri.parse("http://sie-tech.live:7000/appAuthenticate");

    final response =
        await saka.post(apiURL, body: {"username": user, "password": password});

    if (response.statusCode == 404) {
      print("ERROR DE CREDENCIALES");
      log = false;
    }
    if (response.statusCode == 201) {
      print("INICIO DE SESION EXITOSO");
      print("Esto es lo recibido:\n" + response.body);
      var usuario = dataLoggedFromJson(response.body);
      data(usuario);
      print("Este es el tipo de sangre: " + usuario.persona.tipoSangre.tipo);
      log = true;
    }
  }

  Widget confirmar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () async {
          final user = userController.text;
          final password = passController.text;
          await loginRequest(user, password);
          if (log) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Vistalogged(userData)),
            );
          } else {
            //AGREGAR POPUP INDICANDO QUE HUBO ERROR DE INICIO DE SESION
          }

          //print(loginRequest(user, password));
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => homePage()),
          );
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
