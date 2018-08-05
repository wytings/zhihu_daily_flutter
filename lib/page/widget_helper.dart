import 'package:flutter/material.dart';
import 'package:zhihu_daily_flutter/data/data_model.dart';
import 'package:zhihu_daily_flutter/page/story_detail_page.dart';

Widget getStoryContentWidget(BuildContext context, ThemeStoryModel story) {
  var maxLines = 2;
  var height = 60.0;
  if (story.images.isNotEmpty) {
    maxLines = 3;
    height = 100.0;
  }

  final children = <Widget>[
    Expanded(
      child: Container(
        height: height,
        child: Text(
          story.title,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    ),
  ];

  if (story.images.isNotEmpty) {
    children.add(Image.network(
      story.images[0],
      width: 100.0,
      height: 100.0,
    ));
  }

  return GestureDetector(
    onTap: () {
      print('current tap model = ${story.title}');
      StoryDetailPage.push(context, story.title, story.id);
    },
    child: Card(
        child: Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: children,
      ),
    )),
  );
}
