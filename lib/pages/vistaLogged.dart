import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:flutter_try_project/pages/QR_Scanner.dart';
import 'package:flutter_try_project/main.dart';
import 'package:flutter_try_project/pages/personalEmergency.dart';
import 'package:flutter_try_project/pages/tercerosEmergency.dart';
import 'package:flutter_try_project/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_try_project/pages/Scanner.dart';

import 'directEmergency.dart';
//import 'package:http/http.dart';

class Vistalogged extends StatefulWidget {
  final DataLogged data;
  Vistalogged(this.data, {Key key}) : super(key: key);

  @override
  _Vistalogged createState() => _Vistalogged();
}

class _Vistalogged extends State<Vistalogged> {
  //funcion de geolocalizacion

  var location = "";

  void getLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      location = "$position.latitude, $position.longitude";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/login_SIE.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          drawer: Menu(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Ubicación según latitud, longitud: \n"),
              // Text("Position : $location"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Column(
                  children: [
                    Text("Seleccione el tipo de emergencia",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 100,
                    ),
                    personal(context),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),

              /*Container(
            child: confirmar(),
          ),*/

              SizedBox(
                height: 70,
              ),
              Container(
                child: terceros(context),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget personal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          print("Data recibida: " + widget.data.username);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => personalEmergency(widget.data)),
          );
        },
        child: Column(
          children: [
            Icon(
              Icons.person,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Emergencia Personal",
              style: GoogleFonts.lato(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget terceros(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => scan(widget.data)),
          );
          /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => directEmergency()),
        );*/
        },
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Emergencia de un Tercero",
              style: GoogleFonts.lato(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          // ignore: missing_required_param
          UserAccountsDrawerHeader(
            accountName: Text("Bienvenidooo"),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png"),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 500,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => homePage()),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Cerrar sesion",
                              style: GoogleFonts.lato(fontSize: 20),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
