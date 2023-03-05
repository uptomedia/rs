// ignore_for_file: constant_identifier_names

import 'package:basic_utils/basic_utils.dart';
import 'package:calculus/calculus.dart';
import 'package:flutter/cupertino.dart';
import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

enum CalcMode { Normal, Integral, NcR, Hyp, NpR, Fraction }

class CalcuratorController extends GetxController {
  int offset = 0;
  TextEditingController min = TextEditingController();
  TextEditingController max = TextEditingController();
  TextEditingController func = TextEditingController();
  TextEditingController top = TextEditingController();
  TextEditingController bottom = TextEditingController();
  FocusNode minNode = FocusNode();
  FocusNode maxNode = FocusNode();
  FocusNode funcNode = FocusNode();
  FocusNode topNode = FocusNode();
  FocusNode bottomNode = FocusNode();

  var userInput = '';
  var answer = '';
  CalcMode mode = CalcMode.Normal;
  bool isOperator(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void offsetRight() {
    if (topNode.hasFocus) {
      if (offset < top.text.length) offset++;
      top.selection = TextSelection.fromPosition(TextPosition(offset: offset));
    }
    if (bottomNode.hasFocus) {
      if (offset < bottom.text.length) offset++;
      bottom.selection =
          TextSelection.fromPosition(TextPosition(offset: offset));
    }
    update();
  }

  void offsetLeft() {
    if (offset > 0) {
      offset--;
      if (topNode.hasFocus) {
        top.selection =
            TextSelection.fromPosition(TextPosition(offset: offset));
      }
      if (bottomNode.hasFocus) {
        bottom.selection =
            TextSelection.fromPosition(TextPosition(offset: offset));
      }
      update();
    }
  }

  String parseInput(String input) {
    String finaluserinput = input
        .replaceAll("×√", 'nrt')
        .replaceAll(
          '×',
          '*',
        )
        .replaceAll(
          '÷',
          '/',
        )
        .replaceAll(
          'X!',
          '!',
        )
        .replaceAll(
          'π',
          '${math.pi}',
        )
        .replaceAll(
          'e',
          '${math.e}',
        )
        .replaceAll(
          '√',
          'sqrt',
        )
        .replaceAll(
          '∛(',
          'nrt(3,',
        )
        .replaceAll('tanˉ¹', 'arctan')
        .replaceAll('sinˉ¹', 'arcsin')
        .replaceAll("cosˉ¹", "arccos");
    return finaluserinput;
  }

// function to calculate the input operation
  void calculate() {
    try {
      String finaluserinput = parseInput(userInput);

      print(mode);
      if (mode == CalcMode.NpR) {
        double n, r = 0;
        String nfinaluserinput =
            finaluserinput.substring(0, userInput.indexOf('P'));
        print(nfinaluserinput);
        Parser nParser = Parser();
        Expression nexp = nParser.parse(nfinaluserinput);
        ContextModel ncm = ContextModel();
        n = nexp.evaluate(EvaluationType.REAL, ncm);
        String rfinaluserinput =
            finaluserinput.substring(userInput.indexOf('P') + 1);
        print(rfinaluserinput);
        print(userInput);
        Parser rParser = Parser();
        Expression rexp = rParser.parse(rfinaluserinput);
        ContextModel rcm = ContextModel();
        r = rexp.evaluate(EvaluationType.REAL, rcm);

        answer = calculateNPR(n, r).toString();
      } else if (mode == CalcMode.NcR) {
        try {
          double n, r = 0;
          String nfinaluserinput =
              finaluserinput.substring(0, userInput.indexOf('C'));
          print(nfinaluserinput);
          Parser nParser = Parser();
          Expression nexp = nParser.parse(nfinaluserinput);
          ContextModel ncm = ContextModel();
          n = nexp.evaluate(EvaluationType.REAL, ncm);
          String rfinaluserinput =
              finaluserinput.substring(userInput.indexOf('C') + 1);
          print(rfinaluserinput);
          print(userInput);
          Parser rParser = Parser();
          Expression rexp = rParser.parse(rfinaluserinput);
          ContextModel rcm = ContextModel();
          r = rexp.evaluate(EvaluationType.REAL, rcm);
          answer = calculateNCR(n, r).toString();
          update();
        } on Exception catch (e) {
          // TODO
          answer = "Math Error";
          update();
        }
      } else if (mode == CalcMode.Integral) {
        String function = parseInput(func.text);
        final f = function.toSingleVariableFunction();
        answer =
            Calculus.integral(int.parse(min.text), int.parse(max.text), f, 1)
                .toString();
      } else if (mode == CalcMode.Fraction) {
        String topp = parseInput(top.text);
        String botomm = parseInput(bottom.text);
        finaluserinput = "$topp/$botomm";
        Parser p = Parser();
        Expression exp = p.parse(finaluserinput);
        print(exp);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        answer = eval.toString();
      } else if (mode == CalcMode.Hyp) {
        answer = finaluserinput.interpret().toString();
        update();
      } else {
        Parser p = Parser();
        Expression exp = p.parse(finaluserinput);
        print(exp);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        answer = eval.toString();
      }
      if (answer == 'Infinity') {
        answer = 'Math Error';
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      answer = "Syntax Error";
    }
    update();
  }

  void clear() {
    mode = CalcMode.Normal;
    userInput = '';
    answer = '';
    min.clear();
    max.clear();
    func.clear();
    top.clear();
    bottom.clear();
    update();
  }

  double factorial(double k) {
    if (k < 0) {
      throw ArgumentError.value(k);
    }
    if (k == 0) {
      return 1;
    }
    var result = k;
    k--;
    while (k > 1) {
      result *= k;
      k--;
    }
    return result;
  }

  String calculateNCR(double n, double r) {
    if (n - r >= 0) {
      if (r > n - r) r = n - r; // because C(n, r) == C(n, n - r)
      double ans = 1;

      ans = factorial(n) / (factorial(n - r) * factorial(r));

      return ans.toString();
    }
    return "Math Error";
  }

  String calculateNPR(double n, double r) {
    if (n - r >= 0) {
      double ans = 1;

      ans = factorial(n) / factorial(n - r);

      return ans.toString();
    }
    return "Math Error";
  }

  void backspace() {
    if (mode == CalcMode.Integral) {
      if (minNode.hasFocus) {
        min.text = min.text.substring(
          0,
          min.text.length - 1,
        );
      } else if (maxNode.hasFocus) {
        max.text = max.text.substring(
          0,
          max.text.length - 1,
        );
      } else if (funcNode.hasFocus) {
        func.text = func.text.substring(
          0,
          func.text.length - 1,
        );
      }
      update();
    } else if (mode == CalcMode.Fraction) {
      if (topNode.hasFocus) {
        if (offset > top.text.length) {
          offset = top.text.length;
        }
        top.text = StringUtils.removeCharAtPosition(top.text, offset);
        offsetLeft();
        // top.text = top.text.substring(
        //   0,
        //   top.text.length - 1,
        // );
      } else if (bottomNode.hasFocus) {
        if (offset > bottom.text.length) {
          offset = bottom.text.length;
        }
        bottom.text = StringUtils.removeCharAtPosition(bottom.text, offset);
        offsetLeft();
      }
      update();
    } else {
      if (userInput.length == 1) {
        clear();
      } else {
        userInput = userInput.substring(
          0,
          userInput.length - 1,
        );
      }
    }
    update();
  }

  void addText(String text) {
    if (mode == CalcMode.Integral) {
      if (minNode.hasFocus) {
        min.text = min.text + text;
      } else if (maxNode.hasFocus) {
        max.text = max.text + text;
      } else if (funcNode.hasFocus) {
        func.text = func.text + text;
      }
      offsetRight();
      update();
    } else if (mode == CalcMode.Fraction) {
      if (topNode.hasFocus) {
        if (offset > top.text.length) {
          offset = top.text.length;
        }
        top.text = StringUtils.addCharAtPosition(top.text, text, offset);
        offset = top.text.length;
      } else if (bottomNode.hasFocus) {
        if (offset > bottom.text.length) {
          offset = bottom.text.length;
        }
        bottom.text = StringUtils.addCharAtPosition(bottom.text, text, offset);
        offset = bottom.text.length;
      }
      update();
    } else {
      userInput = userInput + text;
      update();
    }
  }
}
