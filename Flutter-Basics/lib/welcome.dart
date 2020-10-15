/*
Stateful widget
- Mutable
- Gives 2 classes
1. For Data
2. For Designing
*/

//it is data class
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

//this class is for designing purpose
class _WelcomeState extends State<Welcome> {
  String msg = "Welcome";

  _getButton(String text, var color) {
    return Container(
      margin: EdgeInsets.only(right: 30, top: 50),
      child: RaisedButton(
        color: color,
        onPressed: () {
          //anonymous fn
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  String firstName = "";
  String lastName = "";

  _getFirstName(String currentValue) {
    firstName = currentValue;
  }

  _getLastName(String currentValue) {
    lastName = currentValue;
  }

  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();

  _welcomeMessage() {
    firstName = ctrl1.text;
    lastName =
        ctrl2.text; //this will extract the text when _welcomeMessage is called
    setState(() {
      //setState is called there is some changes inside it
      //this will rerender the whole screen
      //as re rendering is done when build is called
      //So this will call the build and it will repaint it

      msg += " $firstName $lastName";
    });
  }

  _clearAll() {
    setState(() {
      msg = '';
    });
  }

  //just to segregate the code
  _getTextField(String label, String placeHolder, var iconObj, Function fn,
      TextEditingController ctrl) {
    return Container(
      padding: EdgeInsets.all(7),
      //text field is a widget for Entering Text
      child: TextField(
        style: TextStyle(fontSize: 30),
        keyboardType: TextInputType.text, //email, password
        autocorrect: true,
        autofocus: true,
        //decoration is used to make a TextField look good, rounded corner border , for hinding of text etc
        decoration: InputDecoration(
          labelText: label,
          hintText: placeHolder,
          prefixIcon: iconObj,
          suffixIcon: iconObj,
          border: OutlineInputBorder(),
        ),
        controller:
            ctrl, //controller is being assigned which would be used to control each text field

        //onchange - when we want to listen the changes on Textfield
        //currentValue is a callback value which onChanged automatically provides it

        // onChanged: (String currentValue) {
        //   fn(currentValue);

        //fn will be firstName fn or lastName fn
        //_getFirstName or _getSecondName
        /*
                This fn has been passed from column of _getTextFields
                _getTextField('First Name', "Enter first name", Icons.person, _getFirstName),
                This means onChanged will receive the original functions
                  _getFirstName(String currentValue){
                    firstName = currentValue;
                  }
                
                Now fn(currentValue) is calling the passed funciton
                it is same as _getFirstName(currentValue);
                */
        // },
      ),

      //controller have knowledge of widget change
      //it listen the changes and works same as setState
    );
  } //_getTextField ends here

  @override
  Widget build(BuildContext context) {
    //scaffold is a page or a new screen where we put all the widgets
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        children: <Widget>[
          //now using the _getTextfield
          // _getFirstName(currentValue)//this is calling a functon
          // _getFirstName//this is just passing the function

          _getTextField('First Name', "Enter first name", Icons.person,
              _getFirstName, ctrl1),
          _getTextField('Last Name', "Enter Last name", Icons.accessibility,
              _getLastName, ctrl2),

          //wrapping buttons inside Row because we want them together
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getButton("Welcome", Colors.greenAccent),
              _getButton("Clear", Colors.redAccent)
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            msg,
          )
        ],
      ),
    );
  }
}

/*
Stack Layout - When widget is placed on top of another widget
works in Z axis
*/
