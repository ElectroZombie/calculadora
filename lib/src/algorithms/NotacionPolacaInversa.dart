import "dart:math";

class NotacionPolacaInversa {
  List arr = List.empty(growable: true);
  List p = List.empty(growable: true);
  NotacionPolacaInversa(List arr) {
    this.arr = arr;
  }
  double RPN() {
    String elementoIzquierdo = '';
    String elementoDerecho = '';
    for (var i = 0; i < arr.length; i++) {
      if (operador(arr[i])) {
        elementoDerecho = p.last;
        p.removeLast();
        if (p.isEmpty) {
          throw Exception();
        }
        elementoIzquierdo = p.last;
        p.removeLast();
        num resultado = calcular(elementoIzquierdo, arr[i], elementoDerecho);
        p.add("$resultado");
      } else {
        p.add(arr[i]);
      }
    }
    return double.parse(p.last);
  }

  num calcular(
      String elemento_izquierdo, String operador, String elemento_derecho) {
    double a = double.parse(elemento_izquierdo);
    double b = double.parse(elemento_derecho);
    switch (operador) {
      case "+":
        return a + b;
      case "-":
        return a - b;
      case "*":
        return a * b;
      case "/":
        if (b == 0) {
          return -1;
        }
        return a / b;
      case "%":
        return a % b;
      case "^":
        return pow(a, b);
      default:
        -1;
    }
    ;
    return 0;
  }

  bool operador(String devolver) {
    return devolver == "+" ||
        devolver == "-" ||
        devolver == "*" ||
        devolver == "%" ||
        devolver == "/" ||
        devolver == "^";
  }
}
