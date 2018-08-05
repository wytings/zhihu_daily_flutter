import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/data_base.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'package:zhihu_daily_flutter/page/widget_helper.dart';

class SingleThemePage extends StatefulWidget {
  final String id;

  const SingleThemePage({Key key, this.id}) : super(key: key);

  @override
  _SingleThemePageState createState() => new _SingleThemePageState(id);
}

class _SingleThemePageState extends State<SingleThemePage> {
  final _homeDataList = <_SingleThemeDataModel>[];
  final String id;

  _SingleThemePageState(this.id);

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  @override
  Widget build(BuildContext context) {
    if (_homeDataList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final _SingleThemeDataModel model = _homeDataList[index];
        if (model.type == _TYPE_TOP) {
          return _getTopRowWidget(model.image, model.description);
        } else if (model.type == _TYPE_EDITOR) {
          return _getEditorsRowWidget(model.editors);
        } else if (model.type == _TYPE_STORY) {
          return getStoryContentWidget(context, model.story);
        } else {
          throw Exception('unsupported model = $model');
        }
      },
      itemCount: _homeDataList.length,
    );
  }

  Widget _getTopRowWidget(String image, String description) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _getEditorsRowWidget(List<ThemeEditorModel> editors) {
    if (editors.isEmpty) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.infinity,
            height: 30.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'No Editors',
              ),
            ),
          ));
    }
    var editorList = editors[0].name;
    editors.removeAt(0);
    for (var model in editors) {
      editorList += ',${model.name}';
    }

    return Container(
        padding: EdgeInsets.all(5.0),
        child: SizedBox(
          width: double.infinity,
          height: 30.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              editorList,
            ),
          ),
        ));
  }

  void _requestData() async {
    final List<_SingleThemeDataModel> list = await _requestDataModel();
    setState(() {
      _homeDataList.clear();
      _homeDataList.addAll(list);
    });
  }

  Future<List<_SingleThemeDataModel>> _requestDataModel() async {
    final Data<ThemeDataModel> data = await HttpManager.fetchThemeData(id);
    print("get theme data model, data = ${data.code}");
    final list = <_SingleThemeDataModel>[];

    final topImage = _SingleThemeDataModel(_TYPE_TOP);
    topImage.description = data.entity.description;
    topImage.image = data.entity.image;
    list.add(topImage);

    final editors = _SingleThemeDataModel(_TYPE_EDITOR);
    editors.editors = data.entity.editors;
    list.add(editors);

    for (var story in data.entity.stories) {
      final storyModel = _SingleThemeDataModel(_TYPE_STORY);
      storyModel.story = story;
      list.add(storyModel);
    }
    return list;
  }
}

const int _TYPE_TOP = 1;
const int _TYPE_EDITOR = 2;
const int _TYPE_STORY = 3;

class _SingleThemeDataModel {
  final int type;
  ThemeStoryModel story;
  String description;
  String image;
  List<ThemeEditorModel> editors;

  _SingleThemeDataModel(this.type);
}
