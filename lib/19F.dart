import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'class/model_toilet.dart';
import 'main.dart';

//TODO:ページ遷移もとインポート設定 
// import './pages/home-page.dart';
// import './pages/place-page.dart';
// import './pages/settings-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JMAS\'s RestRoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: My19FPage(title: '19F RestRoom'),
              debugShowCheckedModeBanner: false,
      //TODO:ページ遷移設定
      routes: <String, WidgetBuilder>{
          // '/home': (BuildContext context) => HomePage(),
          // '/place': (BuildContext context) => PlacePage(),
          // '/settings': (BuildContext context) => SettingsPage(),
        },
    );
  }
}

class My19FPage extends StatefulWidget {
  My19FPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<My19FPage> {
  final _mainRefernce = FirebaseDatabase.instance.reference().child("toilet001");
  int _counter = 0;
  List<Toilet> toiletStateList = new List();
  var text = " ";
  Color statusColor;

  @override
  void initState() {
    super.initState();
    _mainRefernce.onChildChanged.listen(_onStatusChanged);
  }
  _onStatusChanged(Event e){
    setState(() {
      Toilet _toilet = new Toilet.fromsnapshot(e.snapshot);
      if (_toilet.useFlag == 0) {
        text = "Empty";
        statusColor = Colors.blue;
      } else {
        text = "Fill";
        statusColor = Colors.red[900];
      }
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

  void _ResetCounter() {
     setState(() {
      _counter = 0;
    });
  }
  Future<void> _onRefresh() async {
    setState((){

    });
}

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: FloatingActionButton(
          onPressed: () => Drawer,
          child:Icon(Icons.menu,color: Colors.white),
        ),
        title: Text(widget.title),
      ),
      drawer : Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child:
                Text(
                  text
                ),
              ),
              ListTile(
                title: Text('18F MEN'),
                onTap: (){
                    setState(() => _incrementCounter());
                    Navigator.pop(context);
                  },
                ),
              ListTile(
                title: Text('18F LADY'),
                onTap: (){
                    setState(() => _incrementCounter());
                    Navigator.pop(context);
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
                  child: Text(text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold ),
                    ),
                  color: statusColor,
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
                  child: const Text('利用状況'),
                  color: Colors.teal[200],
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
                  child: const Text('利用状況'),
                  color: Colors.teal[200],
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
                  child: const Text('利用状況'),
                  color: Colors.teal[200],
                ),
              ],
            ),
          ),
      ),
      floatingActionButton: Column(
        verticalDirection : VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.apps),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: _ResetCounter,
            tooltip: 'Reset',
            child: Icon(Icons.wb_sunny),
            ),
          ),
        ],
      ),
   );
  }
}
