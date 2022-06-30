class ShuntingYard {
  String operacion = "";
  List<String> tokens = List.empty(growable: true);
  List<String> arr = List.empty(growable: true);
  bool flag = false;
  ShuntingYard(String operacion) {
    this.operacion = operacion;
    tokenisar();
    shuntig_yard();
  }

  void tokenisar() {
    RegExp exp = RegExp('[\\(]|\\d+|[-+\\*/.%^]|[\\)]');
    Iterable<Match> matches = exp.allMatches(operacion);
    for (Match m in matches) {
      String token = m[0]!;
      if (token == "." || flag) {
        String x = tokens.last;
        tokens.remove(x);
        x += token;
        tokens.add(x);
        if (flag) {
          flag = false;
          continue;
        }
        flag = true;
        continue;
      }
      tokens.add(token);
    }
  }

  int _darPresedenciaOperacion(String op) {
    switch (op) {
      case '^':
        return 4;
      case '*':
        return 2;
      case '/':
        return 2;
      case '%':
        return 2;
      case '+':
        return 1;
      case '-':
        return 1;
    }
    return 0;
  }

  int _darpresedenciaPila(String op) {
    switch (op) {
      case '^':
        return 3;
      case '*':
        return 2;
      case '/':
        return 2;
      case '%':
        return 2;
      case '+':
        return 1;
      case '-':
        return 1;
    }
    return 0;
  }

  bool compararPresedencia(String operador_expre, String oper_pila) {
    return _darPresedenciaOperacion(operador_expre) <
        _darpresedenciaPila(oper_pila);
  }

  void shuntig_yard() {
    String token = "";
    int count = 0;
    RegExp exp = RegExp('-?\\d+(\\.\\d+)?');
    RegExp exp2 = RegExp('[-+\\*/%^]');

    List p = List.empty(growable: true);
    for (var i = 0; i < tokens.length; i++) {
      token = tokens[i];
      if (exp.hasMatch(token)) {
        arr.add(token);
      } else if (token == '(') {
        p.add(token);
        count++;
      } else if (exp2.hasMatch(token)) {
        if (!p.isEmpty) {
          if (compararPresedencia(token, p.last)) {
            arr.add(p.last);
            p.removeLast();
            p.add(token);
          } else {
            p.add(token);
          }
        } else {
          p.add(token);
        }
      } else if (token == ')') {
        count--;
        if (!p.isEmpty) {
          while (true) {
            if (!p.isEmpty) {
              if (!(p.last == '(')) {
                arr.add(p.last);
                p.removeLast();
              } else {
                p.removeLast();
                break;
              }
            } else {
              break;
            }
          }
        } else {
          throw Exception();
        }
      }
      if (count < 0) {
        throw Exception();
      }
    }
    while (!p.isEmpty) {
      if (!(p.last == '(')) {
        arr.add(p.last);
        p.removeLast();
      } else {
        throw Exception();
      }
    }
  }
}
