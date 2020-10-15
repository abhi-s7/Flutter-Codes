import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String firstName = '';
  _getFirstName(String currentValue) {
    firstName = currentValue;
  }

  String lastName = '';
  _getLastName(String currentValue) {
    lastName = currentValue;
  }

  _getTextField(String label, String placeholder, var iconObj,
      Function passedFunction, TextEditingController ctrl) {
    return Container(
      child: TextField(
        style: TextStyle(fontSize: 20),
        keyboardType: TextInputType.text,
        controller:
            ctrl, //controller is being assigned which would be used to control each text field
        onChanged: (String currentValue) {
          passedFunction(currentValue);
        },
        decoration: InputDecoration(
          hintText: placeholder,
          labelText: label,
          prefixIcon: Icon(
            iconObj,
            size: 30,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  } //_getTextField ends here

  _getButton(String text, var color, Function callingFn) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
        onPressed: () {
          callingFn();
        },
      ),
    );
  }

  String msg = 'Welcome';

  _welcomeMessage() {
    firstName = ctrl1.text;
    lastName =
        ctrl2.text; //this will extract the text when _welcomeMessage is called
    setState(() {
      msg += 'Welcome $firstName $lastName';
      print('Set States called $msg');
    });
  }

  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();

  _clearAll() {
    setState(() {
      msg = '';
      ctrl1.text = '';
      ctrl2.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              _getTextField("First Name", "Enter your First Name", Icons.person,
                  _getFirstName, ctrl1),
              SizedBox(
                height: 10,
              ),
              _getTextField("Last Name", "Enter your Last Name",
                  Icons.person_add_alt_1, _getLastName, ctrl2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getButton('Welcome', Colors.greenAccent, _welcomeMessage),
                  _getButton('Clear All', Colors.redAccent, _clearAll),
                ],
              ),
              SizedBox(height: 30),
              Text(
                msg,
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
