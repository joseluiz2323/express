import 'package:express/myHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'Pagelogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Push(),
    );
  }
}

//jose
class Push extends StatefulWidget {
  Push({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PushState createState() => _PushState();
}

class _PushState extends State<Push> {
  Future sleep2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('option');
    if (boolValue == true) {}
    return new Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyHomePage()));
    });
  }

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  void initState() {
    sleep2();
    _controller = VideoPlayerController.asset("images/10.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.play();
    sleep1();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}
