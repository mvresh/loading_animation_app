import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController dotController;
  Animation<double> animation;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Animation<Offset> offset;
  Animation<Offset> offset1;
  Animation<Offset> offset2;
  Animation<Offset> offset3;

  @override
  void initState() {
    dotController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(dotController);

    offset1 = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -0.3))
        .animate(CurvedAnimation(
      parent: dotController,
      curve: JumpingCurve(0.0, 0.4),
    ));

    dotController.repeat();

//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        dotController.repeat();
//      }
//    });
    //add status listener to get blinking effect
//    dotController.addStatusListener((AnimationStatus buttonAnimationStatus) {
//      if (buttonAnimationStatus == AnimationStatus.completed) {
//        dotController.reverse();
//      } else if (buttonAnimationStatus == AnimationStatus.dismissed) {
//        dotController.forward();
//      }
//    });
    dotController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var tween = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -0.3));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SlideTransition(
                position: tween.animate(CurvedAnimation(
                  parent: dotController,
                  curve: JumpingCurve(0.0, 0.4),
                )),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(
                        color: Colors.grey.shade600,
                        width: 10.0,
                        style: BorderStyle.solid),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SlideTransition(
                position: tween.animate(CurvedAnimation(
                  parent: dotController,
                  curve: JumpingCurve(0.2, 0.6),
                )),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(
                        color: Colors.grey.shade600,
                        width: 10.0,
                        style: BorderStyle.solid),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SlideTransition(
                position: tween.animate(CurvedAnimation(
                  parent: dotController,
                  curve: JumpingCurve(0.4, 0.8),
                )),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(
                        color: Colors.grey.shade600,
                        width: 10.0,
                        style: BorderStyle.solid),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          width: 300.0,
          height: 160.0,
          decoration: new BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: new BorderRadius.circular(75.0),
            border: new Border.all(
              width: 5.0,
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class JumpingCurve extends Curve {
  double begin;
  double end;
  JumpingCurve(this.begin, this.end);
  @override
  double transformInternal(double t) {
    double half = (begin + end) / 2;
    if (t >= begin && t <= half) {
      return ((t - begin) / (half - begin));
    } else if (t > half && t < end) {
      return ((end - t) / (end - half));
    } else {
      return 0;
    }
  }
}
