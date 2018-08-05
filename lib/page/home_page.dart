import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/data_base.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'package:zhihu_daily_flutter/page/widget_helper.dart';

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
        if (model.type == _TYPE_BANNER) {
          return _getBannerRowWidget(model.topStories);
        } else if (model.type == _TYPE_DATE) {
          return _getDateRowWidget(model.date);
        } else if (model.type == _TYPE_STORY) {
          return getStoryContentWidget(model.story);
        } else {
          throw Exception('unsupported model = $model');
        }
      },
      itemCount: _homeDataList.length,
    );
  }

  Widget _getBannerRowWidget(List<TopStoryModel> topStories) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: PageView.builder(
        itemBuilder: (context, i) {
          final top = topStories[i];
          return GestureDetector(
            onTap: () {
              print('${top.title} is clicked');
            },
            child: Image.network(
              top.image,
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: topStories.length,
      ),
    );
  }

  Widget _getDateRowWidget(String date) {
    final dateTime = DateTime.parse(date);
    final dateString = "${dateTime.year }-${dateTime.month.toString()
        .padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return Container(
        padding: EdgeInsets.all(5.0),
        child: SizedBox(
          width: double.infinity,
          height: 30.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dateString,
            ),
          ),
        ));
  }

  void _requestData() async {
    final List<_HomeDataModel> list = await _requestDataModel();
    setState(() {
      _homeDataList.clear();
      _homeDataList.addAll(list);
    });
  }

  Future<List<_HomeDataModel>> _requestDataModel() async {
    final Data<NewsDataModel> data = await HttpManager.fetchNewsData();
    final list = <_HomeDataModel>[];

    final banner = _HomeDataModel(_TYPE_BANNER);
    banner.topStories = data.entity.topStories;
    list.add(banner);

    final dateTitle = _HomeDataModel(_TYPE_DATE);
    dateTitle.date = data.entity.date;
    list.add(dateTitle);

    for (var story in data.entity.stories) {
      final storyModel = _HomeDataModel(_TYPE_STORY);
      storyModel.story = story;
      list.add(storyModel);
    }
    return list;
  }
}

const int _TYPE_BANNER = 1;
const int _TYPE_DATE = 2;
const int _TYPE_STORY = 3;

class _HomeDataModel {
  final int type;
  String date;
  List<TopStoryModel> topStories;
  ThemeStoryModel story;

  _HomeDataModel(this.type);
}
