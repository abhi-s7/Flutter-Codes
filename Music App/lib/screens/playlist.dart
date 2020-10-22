import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_app/db/songcrud.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  _printOneSong(QuerySnapshot song, int index) {
//    print("SONG REC ");
//    print(song.docs[index].get('photo'));
//    print(song.docs[index].get('trackName'));
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.purpleAccent,
        child: ListTile(
          leading: Image.network(song.docs[index].get('photo')),//earlier it was giving a map then we had to retrieve it
          //thus song.docs[index]['photo']
          //but now they have set as getter and setter

          title: Text(song.docs[index].get('trackName')),
          subtitle: Text((song.docs[index].get('albumName')) ?? ''),
          trailing: IconButton(
            icon: Icon(
              Icons.play_circle_filled,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(),
      body: StreamBuilder(//it will refresh by itself if any data is changed
        stream: SongCRUD.getPlaylistStream(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Something went wrong please try again later',
              style: TextStyle(fontSize: 30),
            ));
          }

          //if it comes down then it has data
          //then print the list of the records
          return ListView.builder(
            itemBuilder: (BuildContext bctx, int index) {
              print("Inside ListView Builder ");
              print(snapshot.data);
              return _printOneSong(snapshot.data, index);
              //snapshot.data.docs[index] - this will not work
            },
            itemCount: snapshot.data.docs.length,
            //doc is list of QueryDocument Snapshot
            //Therefore pass this to _printOneSong() one at a time as it contains the details
          );
        },
      ),
    );
  }
}
