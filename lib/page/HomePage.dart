import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/Data.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeDataList = <_HomeDataModel>[];

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
        final _HomeDataModel model = _homeDataList[index];
        if (model.type == TYPE_BANNER) {
          return SizedBox(
            width: double.infinity,
            height: 200.0,
            child: PageView.builder(
              itemBuilder: (context, i) {
                final top = model.topStories[i];
                return Image.network(top.image,fit: BoxFit.cover,);
              },
              itemCount: model.topStories.length,
            ),
          );
        } else if (model.type == TYPE_DATE) {
          return Text(model.date);
        } else if (model.type == TYPE_STORY) {
          return GestureDetector(
            onTap: () {
              print('current tap model = $model');
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  Text(model.story.title),
                  Image.network(
                    model.story.images[0],
                    width: 200.0,
                    height: 200.0,
                  ),
                ],
              ),
            ),
          );
        } else {
          throw Exception('unsupported model = $model');
        }
      },
      itemCount: _homeDataList.length,
    );
  }

  void _requestData() async {
    final List<_HomeDataModel> list = await _getHomeDataModel();
    setState(() {
      _homeDataList.clear();
      _homeDataList.addAll(list);
    });
  }

  Future<List<_HomeDataModel>> _getHomeDataModel() async {
    final Data<NewsDataModel> data = await HttpManager.fetchNewsData();
    final list = <_HomeDataModel>[];

    final banner = _HomeDataModel(TYPE_BANNER);
    banner.topStories = data.entity.topStories;
    list.add(banner);

    final dateTitle = _HomeDataModel(TYPE_DATE);
    dateTitle.date = data.entity.date;
    list.add(dateTitle);

    for (var story in data.entity.stories) {
      final storyModel = _HomeDataModel(TYPE_STORY);
      storyModel.story = story;
      list.add(storyModel);
    }
    return list;
  }
}

const int TYPE_BANNER = 1;
const int TYPE_DATE = 2;
const int TYPE_STORY = 3;

class _HomeDataModel {
  final int type;
  String date;
  List<TopStoryModel> topStories;
  ThemeStoryModel story;

  _HomeDataModel(this.type);
}
