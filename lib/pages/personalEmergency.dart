import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:flutter_try_project/pages/vistaLogged.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_try_project/pages/iniciarSesion.dart';
import 'dart:convert';

// ignore: camel_case_types
class personalEmergency extends StatefulWidget {
  final DataLogged data;
  personalEmergency(this.data, {Key key}) : super(key: key);

  @override
  _personalEmergency createState() => _personalEmergency();
}

// ignore: camel_case_types
class _personalEmergency extends State<personalEmergency> {
  String location;
  var locationMessage;
  var longitud;
  var rawData;
  bool ambulanciaBtn = false;
  bool policiaBtn = false;

  bool bomberoBtn = false;
  List<bool> _selections1 = [false, false, false];

  Future<void> getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      location = "$position";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Selecciona los cuerpos de emergencias",
            style: GoogleFonts.lato(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [botonesEquipos()],
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: confirmar(),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: cancelar(context),
          ),
        ],
      ),
    );
  }

  /////////////////WIDGETS///////////////////////////////////////

  Future personalEmergencyRequest() async {
    final apiURL = Uri.parse("http://10.0.2.2:7000/personal");

    final response = await http.post(apiURL, body: {
      "id": widget.data.id.toString(),
      "location": location.toString(),
      "ambulancia": _selections1[0].toString(),
      "bombero": _selections1[1].toString(),
      "policia": _selections1[2].toString()
    });

    if (response.statusCode == 404) {
      print("ERROR DE CREDENCIALES");
    }
    if (response.statusCode == 201) {
      print("EMERGENCIA SOLICITADA");
      print("Esto es lo recibido:\n" + response.body);
    }
  }

  Widget confirmar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () async {
          await getCurrentLocation();

          /* rawData = {
            "id": widget.data.id,
            "location": location,
            "ambulancia": _selections1[0].toString(),
            "bombero": _selections1[1].toString(),
            "policia": _selections1[2].toString()
          };
 */
          personalEmergencyRequest();

          var lol = jsonEncode(rawData);

          if (locationMessage != "") {
            print("Equipos selected: " + lol);
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
              "Confirmar emergencia",
              style: GoogleFonts.lato(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {
          print("Data recibida: " + widget.data.username);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Vistalogged(widget.data)),
          );
        },
        child: Column(
          children: [
            Icon(
              Icons.cancel_outlined,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text("Cancelar Emergencia", style: GoogleFonts.lato(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  ///// PRUEBA DE TOGGLE BUTTONS/////////

  Widget botonesEquipos() {
    return ToggleButtons(
      isSelected: _selections1,
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: Colors.lightBlue.shade900,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Image(
              image: NetworkImage(
                  "https://image.flaticon.com/icons/png/128/2991/2991352.png"),
              height: 100,
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image(
              image: NetworkImage(
                  "https://image.flaticon.com/icons/png/128/2820/2820482.png"),
              height: 100,
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image(
              image: NetworkImage(
                  "https://image.flaticon.com/icons/png/128/2472/2472632.png"),
              height: 100,
            )),
      ],
      onPressed: (int index) {
        setState(() {
          var isSelected = _selections1;
          isSelected[index] = !isSelected[index];
          _selections1 = isSelected;
        });
      },
    );
  }
}
