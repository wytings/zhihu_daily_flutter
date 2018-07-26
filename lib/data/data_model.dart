// 单个主题数据映射模型
class Theme {
  final String thumbnail;
  final String description;
  final String id;
  final String name;

  Theme(this.thumbnail, this.description, this.id, this.name);

  Theme.fromJson(Map<String, dynamic> json)
      : thumbnail = json['thumbnail'],
        description = json['description'],
        id = json['id'],
        name = json['name'];
}

// 主题内容列表item数据映射模型
class ThemeStory {
  final List<String> images;
  final String type;
  final String id;
  final String title;

  ThemeStory(this.images, this.type, this.id, this.title);

  ThemeStory.fromJson(Map<String, dynamic> json)
      : images = json["images"],
        type = json["type"],
        id = json["id"],
        title = json["title"];
}

// 主题内容列表item数据的编辑映射模型
class ThemeEditor {
  final String url;
  final String bio;
  final String id;
  final String name;
  final String avatar;

  ThemeEditor(this.url, this.bio, this.id, this.name, this.avatar);

  ThemeEditor.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        bio = json["bio"],
        id = json["id"],
        avatar = json["avatar"],
        name = json["name"];
}

// 主题Page数据映射模型
class ThemeData {
  final List<ThemeStory> stories;
  final String description;
  final String background;
  final String name;
  final String image;
  final List<ThemeEditor> editors;

  ThemeData(this.description, this.name, this.background, this.image,
      this.stories, this.editors);

  ThemeData.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        description = json["description"],
        background = json["background"],
        name = json["name"],
        image = json["image"],
        editors = _parseEditor(json["editors"]);
}

// 最新消息中的顶部轮播
class TopStory {
  final String image;
  final String type;
  final String id;
  final String title;

  TopStory(this.image, this.type, this.id, this.title);

  TopStory.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        type = json["type"],
        id = json["id"],
        title = json["title"];
}

// 最新消息Page数据
class NewsData {
  final String date;
  final List<TopStory> topStories;
  final List<ThemeStory> stories;

  NewsData(this.date, this.topStories, this.stories);

  NewsData.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        topStories = _parseTopStory(json["top_stories"]),
        date = json["date"];
}

// 最新消息Page的历史数据
class HistoryNews {
  final String date;
  final List<ThemeStory> stories;

  HistoryNews(this.date, this.stories);

  HistoryNews.fromJson(Map<String, dynamic> json)
      : stories = _parseStory(json["stories"]),
        date = json["date"];
}

// 单个最新消息的数据
class SingleNewsData {
  final String body;
  final String imageSource;
  final String image;
  final String title;
  final String shareUrl;
  final List<String> css;

  SingleNewsData(this.body, this.imageSource, this.image, this.title,
      this.shareUrl, this.css);

  SingleNewsData.fromJson(Map<String, dynamic> json)
      : body = json["body"],
        imageSource = json["image_source"],
        image = json["image"],
        title = json["title"],
        shareUrl = json["share_url"],
        css = json["css"];
}

// 一个消息内容的评论和点赞数
class StoryExtra {
  final int longComments;
  final int popularity;
  final int shortComments;
  final int comments;

  StoryExtra(
      this.longComments, this.popularity, this.shortComments, this.comments);

  StoryExtra.fromJson(Map<String, dynamic> json)
      : longComments = json["long_comments"],
        popularity = json["popularity"],
        shortComments = json["short_comments"],
        comments = json["comments"];
}

// 一个消息内容的评论
class Comment {
  final String author;
  final String content;
  final String avatar;
  final int time;
  final int id;
  final int likes;

  // final dynamic reply_to;

  Comment(
      this.author, this.content, this.avatar, this.time, this.id, this.likes);

  Comment.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        content = json["conent"],
        avatar = json["avatar"],
        time = json["time"],
        id = json["id"],
        likes = json["likes"];
}

List<ThemeStory> _parseStory(List list) {
  return list.map((item) {
    return new ThemeStory.fromJson(item);
  });
}

List<ThemeEditor> _parseEditor(List list) {
  return list.map((item) {
    return new ThemeEditor.fromJson(item);
  });
}

List<TopStory> _parseTopStory(List list) {
  return list.map((item) {
    return new TopStory.fromJson(item);
  });
}
