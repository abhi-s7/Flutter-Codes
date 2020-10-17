import 'package:flutter/material.dart';

class Calc3 extends StatefulWidget {
  @override
  _Calc3State createState() => _Calc3State();
}

class _Calc3State extends State<Calc3> {
  String output = "0";

  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool hasResultGot = false;

  _buttonPressed(String buttonText) {
    if (buttonText == "CE") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == '<-') {
      double num = double.parse(output);

      num /= 10;
      print('num is $num');
      _output = num.toInt().toString();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      if (output == '') return;
      num1 = double.parse(output);

      operand = buttonText;

      _output = "";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      if (operand == '') return;
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      hasResultGot = true;
    } else {
      if (hasResultGot) {
        _output = '';
        hasResultGot = false;
      } else if (_output == '0' || _output == '0.0') _output = '';
      _output = _output + buttonText; //this appends the number
    }

    print(_output);

    setState(() {
      // output = double.parse(_output).toStringAsFixed(2);
      output = _output;
    });
  }

  _buildRow1() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          _buildButton(1, '7', Colors.blueAccent),
          _buildButton(1, '8', Colors.blueAccent),
          _buildButton(1, '9', Colors.blueAccent),
        ],
      ),
    );
  }

  _buildRow2() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          _buildButton(1, '4', Colors.blueAccent),
          _buildButton(1, '5', Colors.blueAccent),
          _buildButton(1, '6', Colors.blueAccent),
        ],
      ),
    );
  }

  _buildRow3() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          _buildButton(1, '1', Colors.blueAccent),
          _buildButton(1, '2', Colors.blueAccent),
          _buildButton(1, '3', Colors.blueAccent),
        ],
      ),
    );
  }

  _buildRow4() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          _buildButton(2, '0', Colors.blueAccent),
          _buildButton(1, '.', Colors.blueAccent),
        ],
      ),
    );
  }

  _buildCol1() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          _buildButton(1, '+', Colors.redAccent),
          _buildButton(1, '-', Colors.redAccent),
          _buildButton(1, '/', Colors.redAccent),
          _buildButton(1, 'x', Colors.redAccent),
        ],
      ),
    );
  }

  _buildCol2() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButton(1, 'CE', Colors.redAccent),
          _buildButton(1, '<-', Colors.redAccent),
          _buildButton(1, '=', Colors.redAccent),
        ],
      ),
    );
  }

  _buildButton(flex, text, color) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => _buttonPressed(text),
        child: Container(
          color: color,
          child: Center(
              //otherwise the Text will not be in center
              child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /***************************************************** */

          //This is yellow portion area as Screen is divided into two halfs vertically
          //First half is where the output will be shown
          //Second half is where the buttons will be shown
          //Therefore I used Expanded with flex 1 for each of the section [output and buttons]

          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 10, bottom: 20),
              alignment: Alignment.bottomRight,
              color: Colors.amberAccent,
              child: Text(
                output,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),

          /****************************************************** */
          /*
          This is the second half which contains buttons
          it is further divided into two halfs horizontally
          One for
          number buttons
            and other for
          operator buttons
          */

          Expanded(
            flex: 1,
            child: Row(
              //this row contains two layouts
              //1. NUmber buttons
              //2. Operator buttos
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        _buildRow1(), //this contains '7', '8', '9' Buttons
                        _buildRow2(), //'4','5','6'
                        _buildRow3(), //'1','2','3'
                        _buildRow4() //'0','.'
                      ],
                    ),
                  ),
                ),
                /***************************************************************/
                /*
                This will contain the Row of Columns
                In first child of Row - Column of '+','-','*','/' Buttons 
                In Second child - Column of 'CE','<-','=' Buttons

                I did so because Operator buttons are 4 and second child of row contains 3 buttons
                otherwise it would be simple
                */

                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.redAccent,
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        children: [_buildCol1(), _buildCol2()],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
