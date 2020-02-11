import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'class/model_toilet.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import "package:transformer_page_view/transformer_page_view.dart";
import '19F.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JMAS\'s RestRoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '18F RestRoom'),
              debugShowCheckedModeBanner: false,

      routes: <String, WidgetBuilder>{
          '/18F': (BuildContext context) => MyHomePage(),
          '/19F': (BuildContext context) => My19FPage(),
          // '/settings': (BuildContext context) => SettingsPage(),
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _mainRefernce = FirebaseDatabase.instance.reference().child("toilet001");
  List<Toilet> toiletStateList = new List();
  var text = " ";
  Color statusColor;
  PageController controller;
  var page_count = 1;
  Icon statusIcon;

  @override
  void initState() {
    super.initState();
    controller = new PageController();
    _mainRefernce.onChildChanged.listen(_onStatusChanged);
  }
  _onStatusChanged(Event e){
    setState(() {
      Toilet _toilet = new Toilet.fromsnapshot(e.snapshot);
      if (_toilet.useFlag == 0) {
        statusIcon = Icon(Icons.radio_button_unchecked);
        statusColor = Colors.blue;
      } else {
        statusIcon = Icon(Icons.clear);
        statusColor = Colors.red[900];
      }
    });
  }

    void pageNumberChange(page) {
    setState(() {
      page_count = page + 1;
    });
  }

  Future<void> _onRefresh() async {
    setState((){

    });
}

//ページ遷移
  Future<T> pushPage<T>(BuildContext context, WidgetBuilder builder, {String name}) {
  return Navigator.push<T>(
    context,
    new CupertinoPageRoute<T>(
      builder: builder,
      settings: new RouteSettings(name: name),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer : Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child:Text(""),
              ),
              ListTile(
                title: Text('18F'),
                onTap: (){
                   pushPage<void>(
                    context,
                    (BuildContext context) {
                      return new MyHomePage();
                    },
                    name: "/18F",
                   );
                  },
                ),
              ListTile(
                title: Text('19F'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name:'/19F'),
                      builder: (BuildContext context) => new My19FPage())
                  );
                  // pushPage<void>(
                  //   context,
                  //   (BuildContext context) {
                  //     return new My19FPage();
                  //   },
                  //   name: "/19F",
                  // );
                  },
                ),
            ],
          ),
        ),
      ),
      body: new RefreshIndicator(
        onRefresh: _onRefresh,
          child: Center(
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.wc,
                      size:30
                  ),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: statusColor,
                  child: statusIcon,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.wc,
                      size:30
                  ),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.clear),
                  color: Colors.red[900],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.wc,
                      size:30
                  ),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.clear),
                  color: Colors.red[900],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.wc,
                      size:30
                  ),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.clear),
                  color: Colors.red[900],
                ),
              ],
            ),
          ),
      ),
   );
  }
}
