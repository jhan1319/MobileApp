import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_try_project/pallete.dart';
import 'package:flutter_try_project/widgets/widgets.dart';
import 'package:flutter_try_project/pages/create-new-account.dart';
import 'package:http/http.dart' as saka;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_try_project/pages/vistaLogged.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool log = false;
  DataLogged userData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/background.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 250,
                      child: Image(
                        image: AssetImage('assets/images/logoSie.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextInputField(
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Usuario',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          controller: userController,
                        ),
                        PasswordInput(
                          icon: FontAwesomeIcons.lock,
                          hint: 'Contraseña',
                          inputAction: TextInputAction.done,
                          controller: passController,
                        ),
                        entrar(context),
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Aún no estás registrado?",
                          style: GoogleFonts.lato(
                              fontSize: 20, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Registrar(context),
                        ),
                      ],
                    ),
                    // RoundedButton(
                    //   buttonName: 'Crear una cuenta',
                    //   onPressed: () {}, //PARA MANDAR EL JSON CON INFO DE LOGIN
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // Widget confirmar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
  //       onPressed: () async {
  //         final user = userController.text;
  //         final password = passController.text;
  //         await loginRequest(user, password);
  //         if (log) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => Vistalogged(userData)),
  //           );
  //         } else {
  //           //AGREGAR POPUP INDICANDO QUE HUBO ERROR DE INICIO DE SESION
  //         }

  //         //print(loginRequest(user, password));
  //       },
  //       child: Column(
  //         children: [
  //           Icon(
  //             Icons.login,
  //             size: 50,
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Text(
  //             "Iniciar Sesión",
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget entrar(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text("Iniciar Sesión",
          style: GoogleFonts.lato(
            fontSize: 20,
          )),
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
    );
  }

  Widget Registrar(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text("Crear cuenta",
          style: GoogleFonts.lato(
            fontSize: 20,
          )),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateNewAccount()),
        );
      },
    );
  }

  Widget registro(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNewAccount()),
          );
        },
        child: Column(
          children: [
            Icon(
              Icons.app_registration,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Crear cuenta",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  DataLogged data(DataLogged user) {
    userData = user;
    return userData;
  }

  Future loginRequest(String user, String password) async {
    //final apiURL = Uri.parse("http://sie-tech.live:7000/appAuthenticate");

    final apiURL = Uri.parse("http://10.0.2.2:7000/appAuthenticate");

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
}
