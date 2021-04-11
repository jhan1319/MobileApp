// To parse this JSON data, do
//
//     final dataLogged = dataLoggedFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_try_project/pages/iniciarSesion.dart';

DataLogged dataLoggedFromJson(String str) =>
    DataLogged.fromJson(json.decode(str));

String dataLoggedToJson(DataLogged data) => json.encode(data.toJson());

class DataLogged {
  DataLogged({
    this.id,
    this.username,
    this.password,
    this.persona,
    this.rol,
  });

  int id;
  String username;
  String password;
  Persona persona;
  Rol rol;

  factory DataLogged.fromJson(Map<String, dynamic> json) => DataLogged(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        persona: Persona.fromJson(json["persona"]),
        rol: Rol.fromJson(json["rol"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "persona": persona.toJson(),
        "rol": rol.toJson(),
      };
}

class Persona {
  Persona({
    this.id,
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.tipoSangre,
    this.ars,
    this.sexo,
    this.nss,
  });

  int id;
  String cedula;
  String nombres;
  String apellidos;
  String fechaNacimiento;
  TipoSangre tipoSangre;
  String ars;
  String sexo;
  String nss;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        cedula: json["cedula"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        fechaNacimiento: json["fecha_nacimiento"],
        tipoSangre: TipoSangre.fromJson(json["tipo_sangre"]),
        ars: json["ars"],
        sexo: json["sexo"],
        nss: json["nss"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "fecha_nacimiento": fechaNacimiento,
        "tipo_sangre": tipoSangre.toJson(),
        "ars": ars,
        "sexo": sexo,
        "nss": nss,
      };
}

class TipoSangre {
  TipoSangre({
    this.id,
    this.tipo,
  });

  int id;
  String tipo;

  factory TipoSangre.fromJson(Map<String, dynamic> json) => TipoSangre(
        id: json["id"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
      };
}

class Rol {
  Rol({
    this.id,
    this.nombre,
    this.listaPermisos,
  });

  int id;
  String nombre;
  List<ListaPermiso> listaPermisos;

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        nombre: json["nombre"],
        listaPermisos: List<ListaPermiso>.from(
            json["lista_permisos"].map((x) => ListaPermiso.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "lista_permisos":
            List<dynamic>.from(listaPermisos.map((x) => x.toJson())),
      };
}

class ListaPermiso {
  ListaPermiso({
    this.id,
    this.nombre,
  });

  int id;
  String nombre;

  factory ListaPermiso.fromJson(Map<String, dynamic> json) => ListaPermiso(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
