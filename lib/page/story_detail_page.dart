import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:zhihu_daily_flutter/data/data_base.dart';
import 'package:zhihu_daily_flutter/data/data_manager.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';

class StoryDetailPage extends StatefulWidget {
  final String id;
  final String title;

  const StoryDetailPage({Key key, this.id, this.title}) : super(key: key);

  @override
  _StoryDetailPageState createState() => new _StoryDetailPageState();

  static void push(BuildContext context, String title, String id) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new StoryDetailPage(
                title: title,
                id: id,
              ),
        ));
  }
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  String url = '';

  @override
  void initState() {
    super.initState();
    _requestUrl();
  }

  void _requestUrl() async {
    Data<SingleNewsDataModel> data =
        await HttpManager.fetchSingleNews(widget.id);
    if (data.code == 0 && data.entity != null) {
      setState(() {
        url = data.entity.shareUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      withZoom: false,
      withLocalStorage: true,
    );
  }
}
