import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class directEmergency extends StatefulWidget {
  directEmergency({Key key}) : super(key: key);

  @override
  _directEmergency createState() => _directEmergency();
}

// ignore: camel_case_types
class _directEmergency extends State<directEmergency> {
  bool ambulanciaBtn = false;
  bool policiaBtn = false;
  bool bomberoBtn = false;
  List<bool> _selections1 = [false, false, false];

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

  Widget confirmar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () {},
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
          Navigator.pop(context);
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

  Widget ambulancia() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          ambulanciaBtn = true;
        });
      },
      child: Column(
        children: [
          Icon(
            Icons.healing_outlined,
            size: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Ambulancia",
          ),
        ],
      ),
    );
  }

  Widget bombero() {
    return ElevatedButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(
            Icons.fire_extinguisher,
            size: 50,
            semanticLabel: "Bomberos",
          ),
          SizedBox(
            height: 5,
          ),
          Text("Bomberos"),
        ],
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
        });
      },
    );
  }

  Widget policia() {
    return ElevatedButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(
            Icons.policy,
            size: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text("Policia"),
        ],
      ),
    );
  }
}
