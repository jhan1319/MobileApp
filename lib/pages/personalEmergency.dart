import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_try_project/classes/dataLogged.dart';
import 'package:flutter_try_project/pages/vistaLogged.dart';
import 'package:flutter_try_project/widgets/background-image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_try_project/pages/iniciarSesion.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: camel_case_types
class personalEmergency extends StatefulWidget {
  final DataLogged data;
  personalEmergency(this.data, {Key key}) : super(key: key);

  @override
  _personalEmergency createState() => _personalEmergency();
}

// ignore: camel_case_types
class _personalEmergency extends State<personalEmergency> {
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
  var locationMessage;
  String latitud;
  var rawData;
  bool ambulanciaBtn = false;
  bool policiaBtn = false;

  bool bomberoBtn = false;
  List<bool> _selections1 = [false, false, false];

  Future<void> getCurrentLocation() async {
    print("Obteniendo ubicación...\n");
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      longitud = position.longitude.toString();
      latitud = position.latitude.toString();
    });
    print("Ubicación obtenida!\n");
  }

  // getItems() {
  //   ListCheckbox.forEach((key, value) {
  //     if (value == true) {
  //       holder_1.add(key);
  //     }
  //   });

  // Printing all selected items on Terminal screen.
  //print(holder_1);
  // Here you will get all your selected Checkbox items.

  // Clear array after use.
  //   holder_1.clear();
  // }

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
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selecciona los cuerpos de emergencias",
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

  Widget causas() {
    if (ambulancia && bomberos && policia) {
      print("KLK0");
      return CausasBomberosAmbulanciaPolicia(context);
    }
    if (bomberos && ambulancia) {
      print("KLK1");
      return CausasBomberosAmbulancia(context);
    }
    if (bomberos && policia) {
      print("KLK2");
      return CausasBomberosPolicia(context);
    }
    if (ambulancia && policia) {
      print("KLK3");
      return CausasPoliciaAmbulancia(context);
    }
    if (bomberos) {
      print("KLK4");
      return CausasBomberos(context);
    }
    if (policia) {
      print("KLK5");
      return CausasPolicia(context);
    }
    if (ambulancia) {
      print("KLK6");
      return CausasAmbulancia(context);
    }
  }

  /////////////////WIDGETS///////////////////////////////////////

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

  Future socketMessage(BuildContext context) async {
    final WebSocketChannel canal = IOWebSocketChannel.connect(
        Uri.parse("ws://10.0.2.2:7000/wsConnect/" + widget.data.id.toString()));
    print("Entró a la función socket");
    canal.sink.add(jsonEncode({
      "id": widget.data.id.toString(),
      "longitud": longitud.toString(),
      "ambulancia": _selections1[0].toString(),
      "bombero": _selections1[1].toString(),
      "policia": _selections1[2].toString()
    }));
    StreamBuilder(
        // initialData: canal.stream.length,
        stream: canal.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data.toString());

          return snapshot.data;
        });
  }

  Future personalEmergencyRequest() async {
    //final apiURL = Uri.parse("http://sie-tech.live:7000/personal");
    final apiURL = Uri.parse("http://10.0.2.2:7000/personal");

    Map<String, bool> causas = {
      'Causas': false,
    };

    if (bomberos) {
      causas = ListCheckboxBomberos;
    }
    if (policia) {
      causas = ListCheckboxPolicia;
    }
    if (ambulancia) {
      causas = ListCheckboxAmbulancia;
    }

    if (bomberos && ambulancia) {
      causas = ListCheckboxBomberosAmbulancia;
    }
    if (bomberos && policia) {
      causas = ListCheckboxBomberosPolicia;
    }
    if (ambulancia && policia) {
      causas = ListCheckboxAmbulanciaPolicia;
    }

    if (ambulancia && bomberos && policia) {
      causas = ListCheckboxBomberosAmbulanciaPolicia;
    }

    final response = await http.post(apiURL, body: {
      "id": widget.data.id.toString(),
      "latitud": latitud.toString(),
      "longitud": longitud.toString(),
      "ambulancia": _selections1[0].toString(),
      "bombero": _selections1[1].toString(),
      "policia": _selections1[2].toString(),
      "procedencia": "personal",
      "Afectados": counter.toString(),
      "Causas": causas.toString()
    });
    //TODO: ALERT QUE INDIQUE QUE SE CREÓ O NO LA EMERGENCIA

    if (response.statusCode == 201) {
      print("EMERGENCIA SOLICITADA");
      print("Esto es lo recibido:\n" + response.body);
      _alerta(context, response.body.toString());
    } else {
      _alerta(context, "Hubo un error al notificar la emergencia");
    }
  }

//   Widget confirmar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
//         onPressed: () async {
//           await getCurrentLocation();

//           /* rawData = {
//             "id": widget.data.id,
//             "location": location,
//             "ambulancia": _selections1[0].toString(),
//             "bombero": _selections1[1].toString(),
//             "policia": _selections1[2].toString()
//           };
//  */
//           personalEmergencyRequest();

//           print(ListCheckboxBomberos);

//           //await socketMessage(context);

//           //var lol = jsonEncode(rawData);
//         },
//         child: Column(
//           children: [
//             Icon(
//               Icons.check_circle_outline_outlined,
//               size: 50,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               "Confirmar emergencia",
//               style: GoogleFonts.lato(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  // Widget cancelar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(1)),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => Vistalogged(widget.data)),
  //         );
  //       },
  //       child: Column(
  //         children: [
  //           Icon(
  //             Icons.cancel_outlined,
  //             size: 50,
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Text("Cancelar Emergencia", style: GoogleFonts.lato(fontSize: 20)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

        /* rawData = {
            "id": widget.data.id,
            "location": location,
            "ambulancia": _selections1[0].toString(),
            "bombero": _selections1[1].toString(),
            "policia": _selections1[2].toString()
          };
 */
        personalEmergencyRequest();

        print(ListCheckboxBomberos);
        print("POSIBLES CAUSAS " +
            ListCheckboxBomberosAmbulanciaPolicia.toString());

        //await socketMessage(context);

        //var lol = jsonEncode(rawData);
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

  ///// PRUEBA DE TOGGLE BUTTONS/////////

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

          ambulancia = isSelected[0];
          bomberos = isSelected[1];
          policia = isSelected[2];
          causas();
        });
      },
    );
  }
}
