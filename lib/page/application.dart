import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/data_base.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'package:zhihu_daily_flutter/page/home_page.dart';
import 'package:zhihu_daily_flutter/page/single_theme_page.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => new _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final _themeModels = <ThemeModel>[];
  ThemeModel currentThemeModel;

  @override
  void initState() {
    super.initState();
    _dispatchDataRequest();
  }

  void _dispatchDataRequest() async {
    final Data<List<ThemeModel>> data = await HttpManager.fetchThemeList();
    setState(() {
      _themeModels.clear();
      _themeModels.add(ThemeModel("", '首页', '', '首页'));
      _themeModels.addAll(data.entity);
    });
  }

  String _getTitle() {
    if (currentThemeModel == null) {
      return '首页';
    }
    return currentThemeModel.name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_getTitle()),
      ),
      body: _getBodyContentWidget(),
      drawer: Drawer(
        child: _getDrawerContentWidget(),
      ),
    );
  }

  Widget _getBodyContentWidget() {
    if (currentThemeModel == null || currentThemeModel.id.isEmpty) {
      return HomePage();
    }
    return SingleThemePage(
        key: ValueKey(currentThemeModel.id), id: currentThemeModel.id);
  }

  Widget _getDrawerContentWidget() {
    if (_themeModels.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemBuilder: (context, i) {
        final themeModel = _themeModels[i];
        return ListTile(
          title: Text("${themeModel.name}"),
          trailing: Icon(
            Icons.navigate_next,
          ),
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
              currentThemeModel = themeModel;
            });
          },
        );
      },
      itemCount: _themeModels.length,
    );
  }
}
