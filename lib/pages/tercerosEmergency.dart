import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_try_project/pages/vistaLogged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class tercerosEmergency extends StatefulWidget {
  final DataLogged data;
  // ignore: non_constant_identifier_names
  final String QR;
  tercerosEmergency(this.data, this.QR, {Key key}) : super(key: key);

  @override
  _tercerosEmergency createState() => _tercerosEmergency();
}

// ignore: camel_case_types
class _tercerosEmergency extends State<tercerosEmergency> {
  bool bomberos = false;
  bool ambulancia = false;
  bool policia = false;
  bool bomberosAmbulancia = false;
  bool bomberosPolicia = false;
  bool bomberosAmbulanciaPolicia = false;
  bool policiaAmbulancia = false;

  Map<String, bool> ListCheckboxPolicia = {
    'Investigación': false,
    'Asalto': false,
    'Asesinato': false,
    'Accidente': false,
    'Toma de rehenes': false,
    'Conflictos comunitarios': false,
  };
  Map<String, bool> ListCheckboxAmbulancia = {
    'Desmayo': false,
    'Traumatismo': false,
    'Herida de bala': false,
    'Accidente vehicular': false,
    'Intoxicación': false,
    'Covid-19': false,
  };
  Map<String, bool> ListCheckboxBomberos = {
    'Incendio': false,
    'Confinamiento': false,
    'Excarselación': false,
    'Evacuación': false,
    'Busqueda de victimas': false,
    'Emergencia menor': false,
  };

  Map<String, bool> ListCheckboxBomberosAmbulancia = {
    'Incendio': false,
    'Confinamiento': false,
    'Excarselación': false,
    'Evacuación': false,
    'Busqueda de victimas': false,
    'Emergencia menor': false,
    'Desmayo': false,
    'Traumatismo': false,
    'Herida de bala': false,
    'Accidente vehicular': false,
    'Intoxicación': false,
    'Covid-19': false,
  };
  Map<String, bool> ListCheckboxBomberosPolicia = {
    'Incendio': false,
    'Confinamiento': false,
    'Excarselación': false,
    'Evacuación': false,
    'Busqueda de victimas': false,
    'Emergencia menor': false,
    'Investigación': false,
    'Asalto': false,
    'Asesinato': false,
    'Accidente': false,
    'Toma de rehenes': false,
    'Conflictos comunitarios': false,
  };
  Map<String, bool> ListCheckboxBomberosAmbulanciaPolicia = {
    'Incendio': false,
    'Confinamiento': false,
    'Excarselación': false,
    'Evacuación': false,
    'Busqueda de victimas': false,
    'Emergencia menor': false,
    'Desmayo': false,
    'Traumatismo': false,
    'Herida de bala': false,
    'Accidente vehicular': false,
    'Intoxicación': false,
    'Covid-19': false,
    'Investigación': false,
    'Asalto': false,
    'Asesinato': false,
    'Accidente': false,
    'Toma de rehenes': false,
    'Conflictos comunitarios': false,
  };
  Map<String, bool> ListCheckboxAmbulanciaPolicia = {
    'Desmayo': false,
    'Traumatismo': false,
    'Herida de bala': false,
    'Accidente vehicular': false,
    'Intoxicación': false,
    'Covid-19': false,
    'Investigación': false,
    'Asalto': false,
    'Asesinato': false,
    'Accidente': false,
    'Toma de rehenes': false,
    'Conflictos comunitarios': false,
  };

  int counter = 0;
  String longitud;
  String latitud;
  var location;
  bool ambulanciaBtn = false;
  bool policiaBtn = false;
  bool bomberoBtn = false;
  List<bool> _selections1 = [false, false, false];

  void add() {
    setState(() {
      counter++;
    });
  }

  void minus() {
    setState(() {
      if (counter != 0) counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Seleccione los cuerpos de emergencias",
                style:
                    GoogleFonts.lato(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [botonesEquipos()],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 2,
                height: 10,
              ),
              Text(
                "Posible cantidad de afectados: ",
                style: GoogleFonts.lato(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menos(),
                  Text(
                    '$counter',
                    style: GoogleFonts.lato(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  mas()
                ],
              ),
              Divider(
                thickness: 2,
                height: 10,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Por favor marque las situaciones que apliquen: ",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 2,
                height: 10,
              ),
              SizedBox(
                height: 350, // constrain height
                child: causas(),
              ),
              Divider(
                thickness: 2,
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Cancel(context), Confirm()],
              ),
            ],
          ),
        ],
      ),
    );
  }

/////////////////WIDGETS///////////////////////////////////////
  Widget Confirm() {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(
        "Confirmar",
        style: GoogleFonts.lato(fontSize: 20),
      ),
      onPressed: () async {
        await getCurrentLocation();

        await tercerosEmergencyRequest();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Vistalogged(widget.data)),
        );
      },
    );
  }

  Widget Cancel(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text("Cancelar",
          style: GoogleFonts.lato(
            fontSize: 20,
          )),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Vistalogged(widget.data)),
        );
      },
    );
  }

  Widget CausasPoliciaAmbulancia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxAmbulanciaPolicia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxAmbulanciaPolicia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxAmbulanciaPolicia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasBomberosAmbulanciaPolicia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children:
              ListCheckboxBomberosAmbulanciaPolicia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxBomberosAmbulanciaPolicia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxBomberosAmbulanciaPolicia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasBomberosPolicia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxBomberosPolicia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxBomberosPolicia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxBomberosPolicia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasBomberosAmbulancia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxBomberosAmbulancia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxBomberosAmbulancia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxBomberosAmbulancia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasBomberos(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxBomberos.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxBomberos[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxBomberos[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasPolicia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxPolicia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxPolicia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxPolicia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget CausasAmbulancia(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: ListCheckboxAmbulancia.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(
                key,
                style: GoogleFonts.lato(fontSize: 20),
              ),
              value: ListCheckboxAmbulancia[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  ListCheckboxAmbulancia[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }

  Widget causas() {
    if (ambulancia && bomberos && policia) {
      return CausasBomberosAmbulanciaPolicia(context);
    }
    if (bomberos && ambulancia) {
      print("KLK");
      return CausasBomberosAmbulancia(context);
    }
    if (bomberos && policia) {
      return CausasBomberosPolicia(context);
    }
    if (ambulancia && policia) {
      return CausasPoliciaAmbulancia(context);
    }

    if (bomberos) {
      return CausasBomberos(context);
    }
    if (policia) {
      return CausasPolicia(context);
    }
    if (ambulancia) {
      return CausasAmbulancia(context);
    }
  }

  Widget mas() {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Icon(FontAwesomeIcons.plus),
      onPressed: () {
        add();
      },
    );
  }

  Widget menos() {
    return ElevatedButton(
      autofocus: true,
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Icon(FontAwesomeIcons.minus),
      onPressed: () {
        minus();
      },
    );
  }

  Future<void> getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      longitud = position.longitude.toString();
      latitud = position.latitude.toString();
    });
  }

  Future tercerosEmergencyRequest() async {
    //final apiURL = Uri.parse("http://sie-tech.live:7000/tercero");
    final apiURL = Uri.parse("http://10.0.2.2:7000/personal");

    final response = await http.post(apiURL, body: {
      "id": widget.data.id.toString(),
      "latitud": latitud.toString(),
      "longitud": longitud.toString(),
      "ambulancia": _selections1[0].toString(),
      "bombero": _selections1[1].toString(),
      "policia": _selections1[2].toString(),
      "scan": widget.QR.toString(),
      "procedencia": "tercero"
    });

    if (response.statusCode == 201) {
      print("EMERGENCIA SOLICITADA");
      print("Esto es lo recibido:\n" + response.body);
      _alerta(context, response.body.toString());
    } else {
      _alerta(context, "Hubo un error al notificar la emergencia");
    }
  }

  Widget confirmar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
        onPressed: () async {
          await getCurrentLocation();

          await tercerosEmergencyRequest();
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

  // ignore: unused_element
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

          ambulancia = isSelected[0];
          bomberos = isSelected[1];
          policia = isSelected[2];
          causas();
        });
      },
    );
  }
}
