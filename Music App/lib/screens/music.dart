import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs.dart';
import 'package:music_app/screens/musicplayer.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as jsonParser;

class Music extends StatefulWidget {
  String _singerName;
  Music(this._singerName);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  //List<Songs> songs = [];
  //Unhandled Exception: type 'List<dynamic>' is not a subtype of type 'List<Songs>'
  //This was due to _fillSongs(var listOfSongs) because var

  List<Song> songs = [];
  _fillSongs(List<dynamic> listOfSongs) {
    //print(listOfSongs.runtimeType); //List<dynamic>

    // listOfSongs.map((singleSong) {
    //   print('Song is ${singleSong['trackName']}');
    // });
    //getting track name
    //listOfSongs.forEach((singleSong) => print(singleSong['collectionName']));

    // var ss = listOfSongs.map((singleSong) {
    //   Song song = new Song();
    //   song.name = singleSong['trackName'];
    //   song.aName = singleSong['collectionName'];
    //   song.url = singleSong['previewUrl'];
    //   return song;
    // }).toList();

    //print(ss.runtimeType);//List<dynamic>

    //both are List<dynamic> still it gives error when specified   _fillSongs(var listOfSongs)

    //map is giving an iterable not the list
    //i.e. it is for just making changes and display each item
    //to make it list use .toList();

    //print('Songs are ::::::$songs');

    var tempSongs = listOfSongs.map((singleSong) {
      Song song = new Song();
      song.name = singleSong['trackName'];
      song.aName = singleSong['collectionName'];
      song.url = singleSong['artworkUrl60'];
      song.audioURL = singleSong[
          'previewUrl']; //this will hold the url of audio file of music
      return song;
    }).toList();

    setState(() {
      songs = tempSongs;
      /*this is really important as When songs comes up into _fillSongs() method
      we add them into tempSongs and in setStates method songs has been changed to tempSongs
      Due to change it will fire up the build method and where there is songs it will refresh the whole list
      */
    });
  }

  AudioPlayer _audioPlayer = AudioPlayer();

  void _playSongs(String url) {
    //best practise is to stop the song first  before running
    _audioPlayer.stop();
    _audioPlayer.play(url); //this will play song over the network
  }

  _loadSongs() {
    String url = Constants.getUrl(widget._singerName);
    Future<http.Response> future = http.get(url);
    //this get is method from http
    //and it is giving Future which contains a response

    future.then((response) {
      //print('Response is ${response.body}');
      //all response are present in response.body
      print('Resoponse is of type ${response.body.runtimeType}');
      /*
      response.body is of type String and this way we cannot extract its data present in it
      Therefore we need to convert it to an Object
      that is done using 'dart:convert'
      This will return a map of dynamic through which we can extract data
      */
      var map = jsonParser.jsonDecode(response.body);
      // print('Map is ${map.runtimeType}');//Map is _InternalLinkedHashMap<String, dynamic>
      _fillSongs(map[
          'results']); //results is the key in map that contains list of songs
    });
  }

  List<Widget> _printSongs() {
    /*
    Now Songs has to be displayed in a list
    so converting each song into a special format i.e. Card where it will be displayed
    To convert element of list we have a method of list.map();//and this will again return a list
    
    */
    return songs.map((song) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          elevation: 5,
          //shape: ShapeBorder(),
          shadowColor: Colors.blueGrey,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                //stack is used to stack up the Image and play button on top of each other
                children: [
                  ClipRRect(
                    //This is used to shape the child i.e. Image in our case

                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      song.url,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    //this will position the Container based on the dimensions from left right
                    //increasing left and right will make the Container smaller - trick
                    left: 14,
                    right: 14,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        //this is to make the circular Container to make it look like Rounded Icon
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              // Image.network(song.url),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  _getText(song.name ?? ''),
                  // '${song.name.substring(0, song.name.length > 30 ? 30 : song.name.length)} ...',
                  softWrap: true,
                ),
              ),
              /*
                This is second option to place the play button but this will be place at the end of Card
                If we don't use Expanded then this button will align itslef after the Text
                So alignment of all the Buttons will not be same as the text length is different for each Song
                Therefore either use MainAsixAlignmen.spaceBetween.
                As Row contains three child. i.e. 1. Image of Song 2. Song name 3. Play Button
                So this will place Image to extreme left and playButton to extreme right
                And middle position will be holded by Song name - but this will make the song name in middle
                If we want Song name to start just after the Image then don't use MainAxisAlignmen.spaceBetween
                Then wrap the IconButton With Align Widget which is used to align the child Widgets
                But this will not work as the Row width will be from Image to Button which will not cover the whole card
                Therefore we have to wrap Align with Expanded.
                Expanded will take the whole available space you can also check using Container as a child
                Now Align can do its task i.e. push the IconButton to extreme right of the Available Space therefore all the IconButtons will be extreme right

                */
              Expanded(
                //     child: Container(
                //   height: 10,
                //   color: Colors.amberAccent,
                // )
                child: Align(
                  //or either use mainAxisAlignment in row to space between
                  //but that will also make the text go in b/w
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.play_circle_filled,
                      size: 30,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                     // _playSongs(song.audioURL);
                     
                      //since song is coming from list of songs which
                      //is list of Song object and Song object contains audioURL

                      //to send it to audio player
                      _callMusicPlayer(song);
                    },
                  ),
                ),
              )
            ],
          ),
        ),

        //ListTile is a good alternative of all the task that we did above
        //as it has leading - starting widget then trailing - ending widget
        //title and subtitle
        //it also resizes the Card according to height required to fit all the text::::::::::::::::::::::::::

        /*
         Card(
          elevation: 10,
          shadowColor: Colors.amberAccent,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListTile(
              title: Text(song.name),
              subtitle: Text(song.aName),
              trailing: Icon(
                Icons.play_circle_fill_sharp,
                color: Colors.blue,
              ),
              leading: Image.network(song.url),
            ),
          ),
        ),
        */
      );
    }).toList(); //.toList() is mandetory don't forget
  }

  String _getText(String text) {
    if (text.length > 30) {
      return '${text.substring(0, 30)}...';
    } else {
      return text;
    }
  }

  _callMusicPlayer(Song song){
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => MusicPlayer(song)));
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          //this will make it scrollable
          child: Column(
            children: _printSongs(),
            //printSongs is returning a List<Widgets> therefore they becomes children
          ),
        ),
      ),
    );
  }
}

/*
Response is a packet - Contains a header and body
response.body  - but it gives String
Therefore we need to convert into object
Use predefined package: 'dart:convert'
  - this convert String into the map
  - .jsonDecode(response.body);//this will give a map

To convert from iterable to list
.toList()

list<dynamic>.map() ///gives the iterable

SingleChildScrollView - this will make any child scrollable

*/

/*
Working
1. First Column is created in body of Scaffold which will hold list of Songs
2. As Column contains list we can pass List of Cards and in each card it will contain image, name and icon to play the song
3. _printSongs() return the List of Widgets i.e. list of cards
4. First of all when the screen loads up pass a funciton to load songs in initStates(){}
5. [63] Url to search the song is coming from Constants.GestureLongPressCallback()
6. To get the Song details from web use http.get(<pass the url>). http is 3rd party package to do async calls
7. This gives future and inside it has repsonse
8. When the future has been resolved it has all the details in response.body
9. But this is in form of String and to convert into object we have to use 'dart:convert'
10. This will make it into Map of dynamics which then can be used to extract details as response contains a lot of juberish data
    we are only interested in 'result' which will contain list of songs
11. Since map['result'] gives a list of songs therefore pass it on to _fillSongs()[80]
12. Fill Songs is responsible for filling the songs from Map into the Global List of Object(Song)
13. Song is a custom object which will have name, artist name and song image url
14. listOfSong.map will extract every child and make operations on it i.e. we have to add trackName, collectionName and artworkUrl60 from the List that has been pased from map['result'] of response
15. Then final step is to add the above to songs global list but add it into setStates
    As when songs are added setState will fireup up which will fire the build method and thus refresh the whole page
    which has been using the <songs> list which is column thus it will get refreshed every time new songs are searched
*/
