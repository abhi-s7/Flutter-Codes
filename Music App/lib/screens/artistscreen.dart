import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as jsonParser;

import 'package:music_app/screens/music.dart';
import 'package:music_app/utils/token.dart';

class ArtistScreen extends StatefulWidget {
  User _user;
  FirebaseAuth _mAuth;
  ArtistScreen(User userObject, FirebaseAuth _mAuth) {
    this._user = userObject;
    //this userObject has been passed from Login Screen
    //i.e. passing the object via constructor
    this._mAuth = _mAuth; //this has been passed from oAuthLogin Screen
  }
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {

  _fetchTheToken() async {
    String token = await Token.readToken();
    //then we can pass this token to firebase and check if it is authenticated then provide data
    //this is double check  
  }
  _sighOut() async {
    if (widget._mAuth != null) {
      //otherwise it will generate null pointer exception
      await widget._mAuth.signOut();
    }
  }

  _getStyle() {
    return TextStyle(fontSize: 16, color: Colors.black);
  }

  _getDrawerListTile(var iconObj, String text) {
    return ListTile(
      onTap: () {
        if (text == 'Signout') _sighOut();
      },
      leading: Icon(
        iconObj,
        color: Colors.black,
        size: 30,
      ),
      title: Text(
        text,
        style: _getStyle(),
      ),
    );
  }

  _getDrawer() {
    return Drawer(
      elevation: 5,
      child: ListView(
        //this makes a vertical view for the children
        children: [
          UserAccountsDrawerHeader(
            //to access the _user which is in parent class
            //therefore to access items of parent inside widget use widget.something
            accountName: Text(widget._user.displayName, style: _getStyle()),
            accountEmail: Text(widget._user.email, style: _getStyle()),
            decoration: BoxDecoration(color: Colors.amberAccent),
            //to show the image of user
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget._user.photoURL),
            ),
          ), //this makes the header of the Drawer
          _getDrawerListTile(Icons.library_music, 'My Playlist'),
          _getDrawerListTile(Icons.money, 'Subscribe'),
          _getDrawerListTile(Icons.person, 'Profile'),
          _getDrawerListTile(Icons.logout, 'Signout'),
        ],
      ),
    );
  }

  //NOTE:::::: If you have an async funciton it always returns a Future
  Future<List<dynamic>> _getAllSingers(String url) async {
    //since itunes api doesnot provide direct search for the artist therefore I has to make a separate JSON having Artist name and its online image url
    http.Response response = await http.get(url);
    //used await here because it will resolve first then give response so need to use future
    String jsonString = response.body;
    Map<String, dynamic> map = jsonParser.jsonDecode(jsonString);
    List<dynamic> list = map['singers'];
    return list;
  }

  _printOneSinger(var singer, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Music(singer[index]['name'])));
          },
          splashColor: Colors.white,
          hoverColor: Colors.white,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purpleAccent, width: 3),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                singer[index]['photo'],
              ), //since it is giving json therefore ['photo' ]
            ),
          ),
        ),
        Container(
          child: Text(
            singer[index]['name'],
            style: _getStyle(),
          ),
        )
      ],
    );
  }

  //grid view is a wrapper on top of row and column
  //it is scrollable and it is dynamic while row n column are not

  _printGrid(AsyncSnapshot snapshot) {
    return GridView.builder(
      //jsut GridView is static while GridView.builder is dynamic
      itemCount: snapshot.data.lenth, //this is the total no of records
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2), //this means 2 column Axis
      //it automatically print no. of rows based on column and total items
      itemBuilder: (BuildContext ctx, int index) {
        //here it is printing the singer
        return _printOneSinger(snapshot.data, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer is in scaffold not in appBar
        drawer: _getDrawer(), //drawer contains icon of its own
        //so no need to specify menu icon in AppBar
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Artist'),
          //leading: Icon(Icons.menu, size:30),
        ),
        //Data is comining from Future
        //once you get the data then build it
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.teal, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
            ),
            FutureBuilder(
              future: _getAllSingers(''),
              //when this future will be resolved it will start building
              //BuildContext is method to server it
              //Whenever a data is coming from the server it has a Snapshot
              builder: (BuildContext ctx, AsyncSnapshot snapShot) {
                if (snapShot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                    //if it doesnot have data then show progress bar
                  );
                }
                //this below is when data is present and it should not be null
                return _printGrid(snapShot);
                //if it doesnot have data then show progress bar
              },
            ),
          ],
        ));
  }
}
