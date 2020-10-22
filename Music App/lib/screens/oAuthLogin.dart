import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_app/screens/artistscreen.dart';
import 'package:music_app/utils/constants.dart';
import 'package:music_app/utils/token.dart';

class OAuthLogin extends StatefulWidget {
  @override
  _OAuthLoginState createState() => _OAuthLoginState();
}

class _OAuthLoginState extends State<OAuthLogin> {
  FirebaseAuth _mAuth = FirebaseAuth.instance;// Instantiating FirebaseAuth i.e. creating object of Firebase Authentication

  //It is responsibility of Firebase to call the underline Authentication service for FB or Google
  GoogleSignIn _googleSignIn = GoogleSignIn();//this will 

  _googleLogin() async {

    //GoogleSignIn contains signIn method which will return a Future which will contain GoogleSigninAccount as a response
   GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();//this will display the Signin page
   //remember to use the await as it should be working in Sync fashiio

   //Now the user id and password entered in signin page must be verified
   GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;//  Future<GoogleSignInAuthentication>

  //once the authentication is done it gives accessToken and idToken
   AuthCredential credential = GoogleAuthProvider.credential(//earlier it was getCredential()
     accessToken: _googleSignInAuth.accessToken,
     idToken: _googleSignInAuth.idToken
   );
    //it will check with the database of Google then give details of User inform of UserCredential
    UserCredential userCredential = await
   _mAuth.signInWithCredential(credential);

   //it has pre defined class
   User userObject = userCredential.user;
   print('User info is $userObject');

   //every call is in await once the response is got it then it show the details

   //For all above to work we have to initialize the firebase in main.dart

   //now pass the userObject to the next screen
   //return userObject;
   //refreshToken.uid - gives the unique userid provided by the firebase

   Token.generateToken(userObject.refreshToken); 

   //refreshToken gives a String
   //getIdToken() gives a future therefore we then have to do future.then

   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ArtistScreen(userObject, _mAuth)));


  }

  _facebookLogin() {}

  _createButton(String url, String text, Function fn) {
    return Center(
      child: Container(
        //Since RaisedButton doesnot have width and height
        //Therefore we must wrap it up in Container
        child: RaisedButton(
          onPressed: () {
            fn();
          },
          child: Row(
            //Row because we want to display Icon and Text together in a Button
            children: [
              Container(margin: EdgeInsets.all(10), child: Image.network(url)),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    //.size is Coming from class Size
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        //container size depends on screen size

        width: deviceSize.width,
        height: deviceSize.height,
        child: Stack(
          children: [
            //I choose stack because I have to integrate positional widgets into the screen
            //and it is only possible through stack not through Column or Row
            Positioned(
              top: 0,
              left: 0,
              child: Image.network(''),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.network(''),
            ),
            Column(
              //to place the buttons
              //But this will start from top as by default stack position it to be on top left
              //Therefore use MainAxisAlignment.center to center it to the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createButton(
                    Constants.LOGIN_GOOGLE_BTN, "Login", _googleLogin),
                _createButton(
                    Constants.LOGIN_fACEBOOK_BTN, "Login", _facebookLogin),
              ],
            ),
          ],
        ),

        //default position of stack is 0,0
      ),
    );
  }
}
