import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs.dart';
//it requires min sdk of 18
//otherwise it will give manifest merger failed

class MusicPlayer extends StatefulWidget {
  Song _song = Song();

  MusicPlayer(Song song) {
    this._song = song;
  }

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Size size;
  double height;
  double width;

  bool _isPlaying = false;
  AudioPlayer audioPlayer;
  Duration _duration; //this gives the duration of that song
  Duration _position;

  _initAudioPlayer() {
    //fisrt thing is to initialize the audio player so that player is ready before playing the songs
    audioPlayer = AudioPlayer();

    //registering the below listeners
    audioPlayer.onDurationChanged.listen((duration) {
      //this intimates about the change in song it gives event as a callback

      setState(() {
        _duration = duration;
      });
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      //the song has been completed playing then make is_plating false
      setState(() {
        _isPlaying = false;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((position) {
      //this gives the current position of the song
      _position = position;
    });
  }

  //playing audio
  play() async {
    int result = await audioPlayer.play(widget._song.audioURL);
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  stop() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  //AudioPlayer

  _getSongBox() {
    return Container(
      width: width,
      height: height * .40,
      color: Colors.blueGrey,
      alignment: Alignment
          .center, //whatever the content it has it will make it into center
      child: Stack(
        //to place the image of song in the container\
        //as we need background so that's why stack
        children: [
          Container(
            //since height and width are not proportional therefore it will not give in circular shape

            // height: height * 0.50,
            // width: width * 0.60,
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget._song.url),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              // image: DecorationImage(
              //   image: NetworkImage(widget
              //       ._song.url), //since song object contains the url of image
            ),
          ),
        ],
      ),
    );
  }

  _getSizedBox() {
    return SizedBox(height: 30);
    //or we can use Divider()
  }

  _getStyle([double size = 30]) {
    //this is optinal parameter i.e. by default size is 30
    return TextStyle(fontSize: size, color: Colors.black);
  }

  _getPlaybackButton(var iconObj, Function fn) {
    return IconButton(
      icon: Icon(
        iconObj,
        size: 30,
      ),
      onPressed: () {
        fn();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _getSongBox(),

            _getSizedBox(),
            Text(
              widget._song.name,
              style: _getStyle(20),
            ),
            Text(
              widget._song.aName,
              style: _getStyle(10),
            ),
            Slider(
              //slider need some value and value cannot be empty
              // value: 10,
              // min: 1,
              // max: 20, //these are static values

              //to drag and drop we need an event
              onChanged: (currentValue) {
                final pos = currentValue * _duration.inMilliseconds;
                // audioPlayer.seek(pos);//this is need if we move song forward or backward
                //but positin must be wrapped inside Duratin

                audioPlayer.seek(Duration(milliseconds: pos.round()));
              },

              value: (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position.inMilliseconds / _duration.inMilliseconds//this is maximum one
                  : 0.0//this is default value,
            ),
            _getSizedBox(), //to create a gap
            Text(
              _position != null ? "${_position.toString().split(".").first}/${_duration.toString().split(".").first}" : "0.0",
              //i..e only print when there is position

              //.toString().split(".").first} - this splits after the dot i.e. fractional part then using.first we make sure to print the first part of the split string
              style: _getStyle(),
            ),
            //row of playback buttons
            Row(
              children: [
                _getPlaybackButton(Icons.volume_down, () async {
                  await audioPlayer.setVolume(0.0);
                  //this accepts a double and 0 means min and 1 means max
                }),
                _getPlaybackButton(_isPlaying ? Icons.pause : Icons.play_arrow,
                    () {
                  if (_isPlaying) {
                    pause();
                  } else {
                    play();
                  }
                }),
                _getPlaybackButton(Icons.stop, () {
                  stop();
                }),
                _getPlaybackButton(Icons.volume_up, () async {
                  await audioPlayer.setVolume(1.0);
                }),
              ],
            ),
            _getSizedBox(),
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {},
              child: Text(
                'Add to Playlist',
                style: _getStyle(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
