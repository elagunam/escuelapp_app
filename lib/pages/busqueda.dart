import 'dart:convert';

import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;

class BusquedaPage extends StatelessWidget {
  final String busqueda;
  const BusquedaPage({Key? key, required this.busqueda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Alumno: ${busqueda}"),
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder<dynamic>(
            future: _buscarAlumno(busqueda),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status']) {
                  var alumno = snapshot.data['alumno'];
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: Icon(
                              Icons.face,
                              color: primaryColor,
                              size: 70,
                            ),
                          )),
                      Container(
                        child: Text(
                          "Nombre: ${alumno['nombre']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Apellidos: ${alumno['ape_paterno']} ${alumno['ape_materno']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Municipio de Residencia: ${alumno['municipio']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Genero: ${alumno['genero']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Generación: ${alumno['generacion']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Telebachillerato: ${alumno['workcenter']['nombre_ct']}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text(
                      snapshot.data['message'],
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.all(10.0),
                    color: Colors.red,
                    alignment: Alignment.center,
                  );
                }
              } else if (snapshot.hasError) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.red,
                  alignment: Alignment.center,
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }));
  }

  Future<dynamic> _buscarAlumno(busqueda) async {
    //TBC130001008
    String url = "http://192.168.8.100:8000/get/alumno/${busqueda}";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      Map<String, dynamic> response =
          jsonDecode(respuesta.body).cast<String, dynamic>();
      return response;
      return jsonDecode(respuesta.body);
    } else {
      print("Error con la respusta");
    }
  }
}
