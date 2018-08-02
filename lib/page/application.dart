import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/Data.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _themeModels = <ThemeModel>[];

  @override
  void initState() {
    super.initState();
    _dispatchDataRequest();
  }

  void _dispatchDataRequest() async {
    final Data<List<ThemeModel>> data = await HttpManager.fetchThemeList();
    setState(() {
      _themeModels.addAll(data.entity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              'Hello',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        final themeModel = _themeModels[i];
        return ListTile(
          title: Text("${themeModel.name}"),
          trailing: Icon(
            Icons.navigate_next,
          ),
          onTap: () {
            setState(() {});
          },
        );
      },
      itemCount: _themeModels.length,
    );
  }
}
