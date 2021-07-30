import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_try_project/pallete.dart';
import 'package:flutter_try_project/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class CreateNewAccount extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController nacimientoController = TextEditingController();
  final TextEditingController sangreController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();
  final TextEditingController arsController = TextEditingController();
  final TextEditingController nssController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String user;
  String cedula;
  String nombres;
  String apellidos;
  String nacimiento;
  String sangre;
  String sexo;
  String ars;
  String nss;
  String pass;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/login_SIE.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400].withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'Usuario',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: userController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.idCard,
                      hint: 'Cédula',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      controller: cedulaController,
                    ),
                    TextInputField(
                      icon: Icons.pending_actions,
                      hint: 'Nombres',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: nombresController,
                    ),
                    TextInputField(
                      icon: Icons.pending_actions,
                      hint: 'Apellidos',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: apellidosController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.solidCalendar,
                      hint: 'yyyy/mm/dd',
                      inputType: TextInputType.datetime,
                      inputAction: TextInputAction.next,
                      controller: nacimientoController,
                    ),
                    TextInputField(
                      icon: Icons.pending_actions,
                      hint: 'Tipo de sangre',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: sangreController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.question,
                      hint: 'Sexo',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: sexoController,
                    ),
                    TextInputField(
                      icon: Icons.pending_actions,
                      hint: 'ARS',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: arsController,
                    ),
                    TextInputField(
                      icon: Icons.pending_actions,
                      hint: 'NSS',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      controller: nssController,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Contraseña',
                      inputAction: TextInputAction.next,
                      controller: passController,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirmar Contraseña',
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    confirmar(context),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ya tienes una cuenta?',
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Login',
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future crearCuentaRequest(BuildContext context) async {
    //final apiURL = Uri.parse("http://sie-tech.live:7000/crearCuentaApp");
    final apiURL = Uri.parse("http://10.0.2.2:7000/crearCuentaApp");

    final response = await http.post(apiURL, body: {
      "user": user,
      "cedula": cedula,
      "nombres": nombres,
      "apellidos": apellidos,
      "nacimiento": nacimiento,
      "sangre": sangre,
      "sexo": sexo,
      "ars": ars,
      "nss": nss,
      "pass": pass,
    });
    //TODO: ALERT QUE INDIQUE QUE SE CREÓ O NO LA EMERGENCIA

    if (response.statusCode == 201) {
      print("CUENTA CREADA ");
      print("Esto es lo recibido:\n" + response.body);
      _alerta(context, response.body.toString());
    } else {
      _alerta(context,
          "Hubo un error al crear su cuenta, por favor inténtelo de nuevo.");
    }
  }

  Future<Widget> _alerta(BuildContext context, String msj) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("NOTIFICACION EMERGENTE"),
          content: Text(msj),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(child: Text("Entendido!!")))
          ],
        );
      },
    );
  }

  Widget confirmar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          if (userController.text != "" &&
              cedulaController.text != "" &&
              nombresController.text != "" &&
              apellidosController.text != "" &&
              nacimientoController.text != "" &&
              sangreController.text != "" &&
              sexoController.text != "" &&
              arsController.text != "" &&
              nssController.text != "" &&
              passController.text != "") {
            user = userController.text;
            cedula = cedulaController.text;
            nombres = nombresController.text;
            apellidos = apellidosController.text;
            nacimiento = nacimientoController.text;
            sangre = sangreController.text;
            sexo = sexoController.text;
            ars = arsController.text;
            nss = nssController.text;
            pass = passController.text;

            crearCuentaRequest(context);

            //Aquí petición para crear la persona & el usuario
          } else {
            _alerta(context,
                "Confirme que todos los campos han sido llenados satisfactoriamente antes de continuar.");
          }
        },
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Confirmar registro",
              style: GoogleFonts.lato(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
