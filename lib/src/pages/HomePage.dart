import 'dart:ui';

import 'package:calculadora/src/algorithms/NotacionPolacaInversa.dart';
import 'package:calculadora/src/algorithms/ShuntignYar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ecuacion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 13, 141, 163),
          title: const Text("Calculadora"),
        ),
        backgroundColor: Color.fromARGB(200, 200, 200, 200),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              ecuacion,
              textAlign: TextAlign.right,
              textScaleFactor: 5.0,
            ),
            Row(children: [
              Expanded(
                child: Column(
                  children: [
                    _crearBoton(label: 'C'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '7'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '4'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '1'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: 'DEL'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _crearBoton(label: '( )'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '8'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '5'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '2'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '0'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _crearBoton(label: '%'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '9'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '6'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '3'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '.'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _crearBoton(label: '/'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '*'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '-'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '+'),
                    const SizedBox(
                      height: 10,
                    ),
                    _crearBoton(label: '='),
                  ],
                ),
              ),
            ]),
          ]),
        ));
  }

  _crearBoton({String label = ''}) {
    return SizedBox(
        height: 70,
        width: 200,
        child: ElevatedButton(
          onPressed: () => _actualizarTexto(label),
          child: Text(label, textScaleFactor: 3),
        ));
  }

  _actualizarTexto(String label) {
    if (label == "C") {
      ecuacion = "";
    } else if (label == "DEL") {
      if (ecuacion == "Error") {
        return;
      }
      if (ecuacion != "") {
        ecuacion = ecuacion.substring(0, ecuacion.length - 1);
      }
    } else if (label == "( )") {
      if (ecuacion == "Error") {
        return;
      }
      RegExp exp2 = RegExp('[-*+\\/%^]');
      if (ecuacion == '') {
        ecuacion += '(';
        return;
      }
      if (exp2.hasMatch(ecuacion[ecuacion.length - 1])) {
        ecuacion += '(';
        return;
      }
      if (ecuacion[ecuacion.length - 1] != "(") {
        ecuacion += ')';
      } else {
        ecuacion += '(';
      }
    } else if (label == '%' ||
        label == '+' ||
        label == '-' ||
        label == '*' ||
        label == '/') {
      if (ecuacion == "Error") {
        return;
      }
      if (ecuacion[ecuacion.length - 1] == ')') {
        ecuacion = ecuacion + label;
      } else if (ecuacion.isEmpty ||
          ecuacion.codeUnitAt(ecuacion.length - 1) < 48 ||
          ecuacion.codeUnitAt(ecuacion.length - 1) > 57 ||
          ecuacion[ecuacion.length - 1] == '(') {
        return;
      } else {
        ecuacion = ecuacion + label;
      }
    } else if (label == '.') {
      if (ecuacion == "Error") {
        return;
      }
      if (ecuacion.isEmpty ||
          ecuacion.codeUnitAt(ecuacion.length - 1) < 48 ||
          ecuacion.codeUnitAt(ecuacion.length - 1) > 57) {
        return;
      }
      bool flagP = false;
      for (int i = 0; i < ecuacion.length; i++) {
        if (ecuacion[i] == '.') {
          flagP = true;
        } else if (ecuacion[i] == '-' ||
            ecuacion[i] == '+' ||
            ecuacion[i] == '*' ||
            ecuacion[i] == '/' ||
            ecuacion[i] == '%') {
          flagP = false;
        }
      }
      if (!flagP) {
        ecuacion = ecuacion + label;
      }
    } else if (label == '=') {
      if (ecuacion == "Error") {
        return;
      }
      _resolverEcuacion();
    } else {
      if (ecuacion == "Error") {
        return;
      }
      if (ecuacion.isNotEmpty && ecuacion[ecuacion.length - 1] == ')') {
        return;
      } else {
        ecuacion = ecuacion + label;
      }
    }
    setState(() {});
  }

  void _resolverEcuacion() {
    ShuntingYard sy = ShuntingYard(ecuacion);
    NotacionPolacaInversa npi = NotacionPolacaInversa(sy.arr);
    double resultado = npi.RPN();
    ecuacion = "$resultado";
    if (ecuacion == '-1') {
      ecuacion = "Error";
    }
  }
}
