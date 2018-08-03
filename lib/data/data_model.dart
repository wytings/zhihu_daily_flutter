// 单个主题数据映射模型
class ThemeModel {
  final String thumbnail;
  final String description;
  final String id;
  final String name;

  ThemeModel(this.thumbnail, this.description, this.id, this.name);

  ThemeModel.fromJson(Map<String, dynamic> json)
      : thumbnail = json['thumbnail'].toString(),
        description = json['description'].toString(),
        id = json['id'].toString(),
        name = json['name'].toString();
}

// 主题内容列表item数据映射模型
class ThemeStoryModel {
  final List<String> images;
  final String type;
  final String id;
  final String title;

  ThemeStoryModel(this.images, this.type, this.id, this.title);

  ThemeStoryModel.fromJson(Map<String, dynamic> json)
      : images = _parseString(json["images"]),
        type = json["type"].toString(),
        id = json["id"].toString(),
        title = json["title"].toString();
}

// 主题内容列表item数据的编辑映射模型
class ThemeEditorModel {
  final String url;
  final String bio;
  final String id;
  final String name;
  final String avatar;

  ThemeEditorModel(this.url, this.bio, this.id, this.name, this.avatar);

  ThemeEditorModel.fromJson(Map<String, dynamic> json)
      : url = json["url"].toString(),
        bio = json["bio"].toString(),
        id = json["id"].toString(),
        avatar = json["avatar"].toString(),
        name = json["name"].toString();
}

// 主题Page数据映射模型
class ThemeDataModel {
  final List<ThemeStoryModel> stories;
  final String description;
  final String background;
  final String name;
  final String image;
  final List<ThemeEditorModel> editors;

  ThemeDataModel(this.description, this.name, this.background, this.image,
      this.stories, this.editors);

  ThemeDataModel.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        description = json["description"].toString(),
        background = json["background"].toString(),
        name = json["name"].toString(),
        image = json["image"].toString(),
        editors = _parseEditor(json["editors"]);
}

// 最新消息中的顶部轮播
class TopStoryModel {
  final String image;
  final String type;
  final String id;
  final String title;

  TopStoryModel(this.image, this.type, this.id, this.title);

  TopStoryModel.fromJson(Map<String, dynamic> json)
      : image = json["image"].toString(),
        type = json["type"].toString(),
        id = json["id"].toString(),
        title = json["title"].toString();
}

// 最新消息Page数据
class NewsDataModel {
  final String date;
  final List<TopStoryModel> topStories;
  final List<ThemeStoryModel> stories;

  NewsDataModel(this.date, this.topStories, this.stories);

  NewsDataModel.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        topStories = _parseTopStory(json["top_stories"]),
        date = json["date"].toString();
}

// 最新消息Page的历史数据
class HistoryNewsModel {
  final String date;
  final List<ThemeStoryModel> stories;

  HistoryNewsModel(this.date, this.stories);

  HistoryNewsModel.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        date = json["date"].toString();
}

// 单个最新消息的数据
class SingleNewsDataModel {
  final String body;
  final String imageSource;
  final String image;
  final String title;
  final String shareUrl;
  final List<String> css;

  SingleNewsDataModel(this.body, this.imageSource, this.image, this.title,
      this.shareUrl, this.css);

  SingleNewsDataModel.fromJson(Map<String, dynamic> json)
      : body = json["body"].toString(),
        imageSource = json["image_source"].toString(),
        image = json["image"].toString(),
        title = json["title"].toString(),
        shareUrl = json["share_url"].toString(),
        css =  _parseString(json["css"]);
}

// 一个消息内容的评论和点赞数
class StoryExtraModel {
  final int longComments;
  final int popularity;
  final int shortComments;
  final int comments;

  StoryExtraModel(
      this.longComments, this.popularity, this.shortComments, this.comments);

  StoryExtraModel.fromJson(Map<String, dynamic> json)
      : longComments = json["long_comments"],
        popularity = json["popularity"],
        shortComments = json["short_comments"],
        comments = json["comments"];
}

// 一个消息内容的评论
class CommentModel {
  final String author;
  final String content;
  final String avatar;
  final int time;
  final int id;
  final int likes;

  // final dynamic reply_to;

  CommentModel(
      this.author, this.content, this.avatar, this.time, this.id, this.likes);

  CommentModel.fromJson(Map<String, dynamic> json)
      : author = json["author"].toString(),
        content = json["conent"].toString(),
        avatar = json["avatar"].toString(),
        time = json["time"],
        id = json["id"],
        likes = json["likes"];
}

List<ThemeStoryModel> _parseStory(List list) {
  final List<ThemeStoryModel> modelList = [];
  for (var map in list) {
    modelList.add(ThemeStoryModel.fromJson(map));
  }
  return modelList;
}

List<ThemeEditorModel> _parseEditor(List list) {
  final List<ThemeEditorModel> modelList = [];
  for (var map in list) {
    modelList.add(ThemeEditorModel.fromJson(map));
  }
  return modelList;
}

List<TopStoryModel> _parseTopStory(List list) {
  final List<TopStoryModel> modelList = [];
  for (var map in list) {
    modelList.add(TopStoryModel.fromJson(map));
  }
  return modelList;
}

List<String> _parseString(List list) {
  final List<String> modelList = [];
  for (var map in list) {
    modelList.add(map.toString());
  }
  return modelList;
}
