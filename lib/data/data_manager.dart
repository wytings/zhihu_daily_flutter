import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:zhihu_daily_flutter/data/Data.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'dart:convert';

class HttpManager {
  // 主题日报列表查看
  static Future<Data<List<ThemeModel>>> fetchThemeList() async {
    final String url = "https://news-at.zhihu.com/api/4/themes";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List others = data.entity["others"];
      final List<ThemeModel> modelList = [];
      for (var map in others) {
        modelList.add(new ThemeModel.fromJson(map));
      }

      return new Data(0, "", modelList);
    }
    return new Data(data.code, data.msg, null);
  }

  // 主题日报内容查看
  static Future<Data<ThemeDataModel>> fetchThemeData(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/themes/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", ThemeDataModel.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 最新消息
  static Future<Data<NewsDataModel>> fetchNewsData() async {
    final String url = "https://news-at.zhihu.com/api/4/news/latest";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", NewsDataModel.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 消息内容获取
  static Future<Data<SingleNewsDataModel>> fetchSingleNews(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/news/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", SingleNewsDataModel.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 过往消息
  static Future<Data<HistoryNewsModel>> fetchHistoryNews(String date) async {
    final String url = "https://news-at.zhihu.com/api/4/news/before/$date";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", HistoryNewsModel.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻额外信息
  static Future<Data<StoryExtraModel>> fetchStoryExtra(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/story-extra/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", StoryExtraModel.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻对应长评论查看
  static Future<Data<List<CommentModel>>> fetchLongComment(String id) async {
    final String url =
        "https://news-at.zhihu.com/api/4/story/$id/long-comments";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List comments = data.entity["comments"];
      final List<CommentModel> result = comments.map((model) {
        return new CommentModel.fromJson(model);
      });
      return new Data(0, "", result);
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻对应短评论查看
  static Future<Data<List<CommentModel>>> fetchShortComment(String id) async {
    final String url =
        "https://news-at.zhihu.com/api/4/story/$id/short-comments";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List comments = data.entity["comments"];
      final List<CommentModel> result = comments.map((model) {
        return new CommentModel.fromJson(model);
      });
      return new Data(0, "", result);
    }
    return new Data(data.code, data.msg, null);
  }

  static Future<Data<dynamic>> _fetchContent(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return new Data(0, "", jsonDecode(response.body));
    }
    return new Data(response.statusCode, response.body, null);
  }
}
