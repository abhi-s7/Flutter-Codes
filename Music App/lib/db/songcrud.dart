import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/models/songs.dart';

class SongCRUD{
  //to instantiate the database document
  static final dbRef = FirebaseFirestore.instance;
  //static because we don't want to create object of this class to access it
  //final is runtime constant

  static Future<bool> _addNewSong(Song song) async{

    //as docRef gives Future
    DocumentReference docRef = await dbRef.collection('songs').add({
      'name': song.name,
      'artistName' : song.aName,
      'songUrl': song.url,
      'audioUrl' : song.audioURL
    });
    print('DB ref is ${docRef.id}');
    //docRef.documentID - deprecated
    return true;
  }

  //this is for static loading
  static _converToSongList(QuerySnapshot snapshot){
    List<Song> songs = snapshot.docs//this gives list of QuerySnapshot
            .map((doc){
              Song song = Song();
              song.name = doc['trackName'];
              song.aName = doc['albumName'];
              song.url = doc['photo'];
              song.audioURL = doc['audio'];
              return song;
            });
    return songs;
  }

  //Future
  //if Not written Future<> then it will also work because it is dynamic and it does that by default
  static Future<List<Song>> getPlaylist() async{
    QuerySnapshot snapshot = await dbRef.collection('songs').get();
    //earlier .getDocumnets()
    List<Song> songList = _converToSongList(snapshot);
    return songList;
  }

  //Stream
  //this method is truely dedicated to StreamBuilder as it requires stream not the Future
  static Stream<QuerySnapshot> getPlaylistStream(){
    //..get() gives Future<QuerySnapshot>
    Stream<QuerySnapshot> snapshot = dbRef.collection('songs').snapshots();
    print('Snap shot stream');
    print(snapshot);
    return snapshot;
      //List<Song> songList = _convertToSongList(snapShot);
    //return songList;
  }
}