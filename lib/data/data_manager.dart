import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:zhihu_daily_flutter/data/Data.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'dart:convert';

class HttpManager {
  // 主题日报列表查看
  Future<Data<List<Theme>>> fetchThemeList() async {
    final String url = "https://news-at.zhihu.com/api/4/themes";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List others = data.entity["others"];
      final List<Theme> modelList = others.map((model) {
        return new Theme.fromJson(model);
      });
      return new Data(0, "", modelList);
    }
    return new Data(data.code, data.msg, null);
  }

  // 主题日报内容查看
  Future<Data<ThemeData>> fetchThemeData(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/themes/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", ThemeData.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 最新消息
  Future<Data<NewsData>> fetchNewsData() async {
    final String url = "https://news-at.zhihu.com/api/4/news/latest";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", NewsData.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 消息内容获取
  Future<Data<SingleNewsData>> fetchSingleNews(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/news/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", SingleNewsData.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 过往消息
  Future<Data<HistoryNews>> fetchHistoryNews(String date) async {
    final String url = "https://news-at.zhihu.com/api/4/news/before/$date";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", HistoryNews.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻额外信息
  Future<Data<StoryExtra>> fetchStoryExtra(String id) async {
    final String url = "https://news-at.zhihu.com/api/4/story-extra/$id";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      return new Data(0, "", StoryExtra.fromJson(data.entity));
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻对应长评论查看
  Future<Data<List<Comment>>> fetchLongComment(String id) async {
    final String url =
        "https://news-at.zhihu.com/api/4/story/$id/long-comments";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List comments = data.entity["comments"];
      final List<Comment> result = comments.map((model) {
        return new Comment.fromJson(model);
      });
      return new Data(0, "", result);
    }
    return new Data(data.code, data.msg, null);
  }

  // 新闻对应短评论查看
  Future<Data<List<Comment>>> fetchShortComment(String id) async {
    final String url =
        "https://news-at.zhihu.com/api/4/story/$id/short-comments";
    final Data<dynamic> data = await _fetchContent(url);
    if (data.code == 0) {
      final List comments = data.entity["comments"];
      final List<Comment> result = comments.map((model) {
        return new Comment.fromJson(model);
      });
      return new Data(0, "", result);
    }
    return new Data(data.code, data.msg, null);
  }

  Future<Data<dynamic>> _fetchContent(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return new Data(0, "", jsonDecode(response.body));
    }
    return new Data(response.statusCode, response.body, null);
  }
}
