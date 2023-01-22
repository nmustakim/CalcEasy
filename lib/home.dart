import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String input = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "0";
        result = "0";
      } else if (buttonText == "del") {
        if (input == "") {
          result = "0";
        } else {
          input = input.substring(0, input.length - 1);
        }
      } else if (buttonText == "=") {
        expression = input;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (err) {
          result = "Error!";
        }
      } else {
        if (input == "0") {
          input = buttonText;
        } else {
          input = input + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.075 * buttonHeight,
          width: MediaQuery.of(context).size.width / 4.128,
          child: ElevatedButton(
              onPressed: (() => buttonPressed(buttonText)),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: null,
        title: const Text("Calcasy"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(),
                ),
              ),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              ListTile(leading: Icon(Icons.help), title: Text("Help")),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              ListTile(
                  leading: Icon(Icons.album_outlined), title: Text("About")),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              ListTile(
                  leading: Icon(Icons.contact_page), title: Text("Contact")),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lightGreen,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
                  child: Text(
                    input,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  result,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: Colors.black),
                ),
              ),
              const Expanded(
                  child: Divider(
                color: Colors.white,
              )),
              Row(
                children: [
                  buildButton(
                    "C",
                    1,
                  ),
                  buildButton(
                    "del",
                    1,
                  ),
                  buildButton(
                    " / ",
                    1,
                  ),
                  Expanded(
                      child: buildButton(
                    " * ",
                    1,
                  )),
                ],
              ),
              Row(
                children: [
                  buildButton(
                    "1",
                    1,
                  ),
                  buildButton(
                    "2",
                    1,
                  ),
                  buildButton(
                    "3",
                    1,
                  ),
                  Expanded(
                      child: buildButton(
                    " - ",
                    1,
                  )),
                ],
              ),
              Row(
                children: [
                  buildButton(
                    "4",
                    1,
                  ),
                  buildButton(
                    "5",
                    1,
                  ),
                  buildButton(
                    "6",
                    1,
                  ),
                  Expanded(
                      child: buildButton(
                    " + ",
                    1,
                  )),
                ],
              ),
              Row(
                children: [
                  buildButton(
                    "7",
                    1,
                  ),
                  buildButton(
                    "8",
                    1,
                  ),
                  buildButton(
                    "9",
                    1,
                  ),
                  Expanded(
                      child: buildButton(
                    "0",
                    1,
                  )),
                ],
              ),
              Row(
                children: [
                  buildButton(
                    "00",
                    1,
                  ),
                  buildButton(
                    ".",
                    1,
                  ),
                  Expanded(
                      child: buildButton(
                    "=",
                    1,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
