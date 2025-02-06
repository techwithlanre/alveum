import 'dart:convert';
/// id : 7679117
/// pageURL : "https://pixabay.com/photos/flower-stamens-hypericum-macro-7679117/"
/// type : "photo"
/// tags : "flower, stamens, nature, hypericum, flower background, macro, yellow, flower, yellow, yellow, yellow, beautiful flowers, flower wallpaper, yellow, yellow"
/// previewURL : "https://cdn.pixabay.com/photo/2022/12/26/13/50/flower-7679117_150.jpg"
/// previewWidth : 150
/// previewHeight : 100
/// webformatURL : "https://pixabay.com/get/g884450bea6a163775b66b8aec4f137dad3ec4a6289ee4c33cf90155acebd490b7bc8cf67e57642194eaf06d5d9d675ca59aa1ab8df44366109012d0fcc8d6d42_640.jpg"
/// webformatWidth : 640
/// webformatHeight : 427
/// largeImageURL : "https://pixabay.com/get/gdaeb519ad86c70ce39d15276fd951cb26c965af9ea8c5f4d7d95851c47cb22d278c12a054a0ed173a36f035ff4a9e54d96a6cce532196529cee700ee2884a246_1280.jpg"
/// imageWidth : 6000
/// imageHeight : 4000
/// imageSize : 8137356
/// videos : {"large":{"url":"https://cdn.pixabay.com/video/2024/05/22/213050_large.mp4","width":3840,"height":2160,"size":17900968,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_large.jpg"},"medium":{"url":"https://cdn.pixabay.com/video/2024/05/22/213050_medium.mp4","width":2560,"height":1440,"size":6816895,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_medium.jpg"},"small":{"url":"https://cdn.pixabay.com/video/2024/05/22/213050_small.mp4","width":1920,"height":1080,"size":3757838,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_small.jpg"},"tiny":{"url":"https://cdn.pixabay.com/video/2024/05/22/213050_tiny.mp4","width":1280,"height":720,"size":1249720,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_tiny.jpg"}}
/// views : 26787
/// downloads : 20556
/// collections : 851
/// likes : 123
/// comments : 20
/// user_id : 4379051
/// user : "4379051"
/// userImageURL : ""

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());
class Post {
  Post({
      this.id, 
      this.pageURL, 
      this.type, 
      this.tags, 
      this.previewURL, 
      this.previewWidth, 
      this.previewHeight, 
      this.webformatURL, 
      this.webformatWidth, 
      this.webformatHeight, 
      this.largeImageURL, 
      this.imageWidth, 
      this.imageHeight, 
      this.imageSize, 
      this.videos, 
      this.views, 
      this.downloads, 
      this.collections, 
      this.likes, 
      this.comments, 
      this.userId, 
      this.user, 
      this.userImageURL,});

  Post.fromJson(dynamic json) {
    id = json['id'];
    pageURL = json['pageURL'];
    type = json['type'];
    tags = json['tags'];
    previewURL = json['previewURL'];
    previewWidth = json['previewWidth'];
    previewHeight = json['previewHeight'];
    webformatURL = json['webformatURL'];
    webformatWidth = json['webformatWidth'];
    webformatHeight = json['webformatHeight'];
    largeImageURL = json['largeImageURL'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    imageSize = json['imageSize'];
    videos = json['videos'] != null ? Videos.fromJson(json['videos']) : null;
    views = json['views'];
    downloads = json['downloads'];
    collections = json['collections'];
    likes = json['likes'];
    comments = json['comments'];
    userId = json['user_id'];
    user = json['user'];
    userImageURL = json['userImageURL'];
  }
  num? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  num? previewWidth;
  num? previewHeight;
  String? webformatURL;
  num? webformatWidth;
  num? webformatHeight;
  String? largeImageURL;
  num? imageWidth;
  num? imageHeight;
  num? imageSize;
  Videos? videos;
  num? views;
  num? downloads;
  num? collections;
  num? likes;
  num? comments;
  num? userId;
  String? user;
  String? userImageURL;
Post copyWith({  num? id,
  String? pageURL,
  String? type,
  String? tags,
  String? previewURL,
  num? previewWidth,
  num? previewHeight,
  String? webformatURL,
  num? webformatWidth,
  num? webformatHeight,
  String? largeImageURL,
  num? imageWidth,
  num? imageHeight,
  num? imageSize,
  Videos? videos,
  num? views,
  num? downloads,
  num? collections,
  num? likes,
  num? comments,
  num? userId,
  String? user,
  String? userImageURL,
}) => Post(  id: id ?? this.id,
  pageURL: pageURL ?? this.pageURL,
  type: type ?? this.type,
  tags: tags ?? this.tags,
  previewURL: previewURL ?? this.previewURL,
  previewWidth: previewWidth ?? this.previewWidth,
  previewHeight: previewHeight ?? this.previewHeight,
  webformatURL: webformatURL ?? this.webformatURL,
  webformatWidth: webformatWidth ?? this.webformatWidth,
  webformatHeight: webformatHeight ?? this.webformatHeight,
  largeImageURL: largeImageURL ?? this.largeImageURL,
  imageWidth: imageWidth ?? this.imageWidth,
  imageHeight: imageHeight ?? this.imageHeight,
  imageSize: imageSize ?? this.imageSize,
  videos: videos ?? this.videos,
  views: views ?? this.views,
  downloads: downloads ?? this.downloads,
  collections: collections ?? this.collections,
  likes: likes ?? this.likes,
  comments: comments ?? this.comments,
  userId: userId ?? this.userId,
  user: user ?? this.user,
  userImageURL: userImageURL ?? this.userImageURL,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pageURL'] = pageURL;
    map['type'] = type;
    map['tags'] = tags;
    map['previewURL'] = previewURL;
    map['previewWidth'] = previewWidth;
    map['previewHeight'] = previewHeight;
    map['webformatURL'] = webformatURL;
    map['webformatWidth'] = webformatWidth;
    map['webformatHeight'] = webformatHeight;
    map['largeImageURL'] = largeImageURL;
    map['imageWidth'] = imageWidth;
    map['imageHeight'] = imageHeight;
    map['imageSize'] = imageSize;
    if (videos != null) {
      map['videos'] = videos?.toJson();
    }
    map['views'] = views;
    map['downloads'] = downloads;
    map['collections'] = collections;
    map['likes'] = likes;
    map['comments'] = comments;
    map['user_id'] = userId;
    map['user'] = user;
    map['userImageURL'] = userImageURL;
    return map;
  }

}

/// large : {"url":"https://cdn.pixabay.com/video/2024/05/22/213050_large.mp4","width":3840,"height":2160,"size":17900968,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_large.jpg"}
/// medium : {"url":"https://cdn.pixabay.com/video/2024/05/22/213050_medium.mp4","width":2560,"height":1440,"size":6816895,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_medium.jpg"}
/// small : {"url":"https://cdn.pixabay.com/video/2024/05/22/213050_small.mp4","width":1920,"height":1080,"size":3757838,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_small.jpg"}
/// tiny : {"url":"https://cdn.pixabay.com/video/2024/05/22/213050_tiny.mp4","width":1280,"height":720,"size":1249720,"thumbnail":"https://cdn.pixabay.com/video/2024/05/22/213050_tiny.jpg"}

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));
String videosToJson(Videos data) => json.encode(data.toJson());
class Videos {
  Videos({
      this.large, 
      this.medium, 
      this.small, 
      this.tiny,});

  Videos.fromJson(dynamic json) {
    large = json['large'] != null ? Large.fromJson(json['large']) : null;
    medium = json['medium'] != null ? Medium.fromJson(json['medium']) : null;
    small = json['small'] != null ? Small.fromJson(json['small']) : null;
    tiny = json['tiny'] != null ? Tiny.fromJson(json['tiny']) : null;
  }
  Large? large;
  Medium? medium;
  Small? small;
  Tiny? tiny;
Videos copyWith({  Large? large,
  Medium? medium,
  Small? small,
  Tiny? tiny,
}) => Videos(  large: large ?? this.large,
  medium: medium ?? this.medium,
  small: small ?? this.small,
  tiny: tiny ?? this.tiny,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (large != null) {
      map['large'] = large?.toJson();
    }
    if (medium != null) {
      map['medium'] = medium?.toJson();
    }
    if (small != null) {
      map['small'] = small?.toJson();
    }
    if (tiny != null) {
      map['tiny'] = tiny?.toJson();
    }
    return map;
  }

}

/// url : "https://cdn.pixabay.com/video/2024/05/22/213050_tiny.mp4"
/// width : 1280
/// height : 720
/// size : 1249720
/// thumbnail : "https://cdn.pixabay.com/video/2024/05/22/213050_tiny.jpg"

Tiny tinyFromJson(String str) => Tiny.fromJson(json.decode(str));
String tinyToJson(Tiny data) => json.encode(data.toJson());
class Tiny {
  Tiny({
      this.url, 
      this.width, 
      this.height, 
      this.size, 
      this.thumbnail,});

  Tiny.fromJson(dynamic json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    thumbnail = json['thumbnail'];
  }
  String? url;
  num? width;
  num? height;
  num? size;
  String? thumbnail;
Tiny copyWith({  String? url,
  num? width,
  num? height,
  num? size,
  String? thumbnail,
}) => Tiny(  url: url ?? this.url,
  width: width ?? this.width,
  height: height ?? this.height,
  size: size ?? this.size,
  thumbnail: thumbnail ?? this.thumbnail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['size'] = size;
    map['thumbnail'] = thumbnail;
    return map;
  }

}

/// url : "https://cdn.pixabay.com/video/2024/05/22/213050_small.mp4"
/// width : 1920
/// height : 1080
/// size : 3757838
/// thumbnail : "https://cdn.pixabay.com/video/2024/05/22/213050_small.jpg"

Small smallFromJson(String str) => Small.fromJson(json.decode(str));
String smallToJson(Small data) => json.encode(data.toJson());
class Small {
  Small({
      this.url, 
      this.width, 
      this.height, 
      this.size, 
      this.thumbnail,});

  Small.fromJson(dynamic json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    thumbnail = json['thumbnail'];
  }
  String? url;
  num? width;
  num? height;
  num? size;
  String? thumbnail;
Small copyWith({  String? url,
  num? width,
  num? height,
  num? size,
  String? thumbnail,
}) => Small(  url: url ?? this.url,
  width: width ?? this.width,
  height: height ?? this.height,
  size: size ?? this.size,
  thumbnail: thumbnail ?? this.thumbnail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['size'] = size;
    map['thumbnail'] = thumbnail;
    return map;
  }

}

/// url : "https://cdn.pixabay.com/video/2024/05/22/213050_medium.mp4"
/// width : 2560
/// height : 1440
/// size : 6816895
/// thumbnail : "https://cdn.pixabay.com/video/2024/05/22/213050_medium.jpg"

Medium mediumFromJson(String str) => Medium.fromJson(json.decode(str));
String mediumToJson(Medium data) => json.encode(data.toJson());
class Medium {
  Medium({
      this.url, 
      this.width, 
      this.height, 
      this.size, 
      this.thumbnail,});

  Medium.fromJson(dynamic json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    thumbnail = json['thumbnail'];
  }
  String? url;
  num? width;
  num? height;
  num? size;
  String? thumbnail;
Medium copyWith({  String? url,
  num? width,
  num? height,
  num? size,
  String? thumbnail,
}) => Medium(  url: url ?? this.url,
  width: width ?? this.width,
  height: height ?? this.height,
  size: size ?? this.size,
  thumbnail: thumbnail ?? this.thumbnail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['size'] = size;
    map['thumbnail'] = thumbnail;
    return map;
  }

}

/// url : "https://cdn.pixabay.com/video/2024/05/22/213050_large.mp4"
/// width : 3840
/// height : 2160
/// size : 17900968
/// thumbnail : "https://cdn.pixabay.com/video/2024/05/22/213050_large.jpg"

Large largeFromJson(String str) => Large.fromJson(json.decode(str));
String largeToJson(Large data) => json.encode(data.toJson());
class Large {
  Large({
      this.url, 
      this.width, 
      this.height, 
      this.size, 
      this.thumbnail,});

  Large.fromJson(dynamic json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    thumbnail = json['thumbnail'];
  }
  String? url;
  num? width;
  num? height;
  num? size;
  String? thumbnail;
Large copyWith({  String? url,
  num? width,
  num? height,
  num? size,
  String? thumbnail,
}) => Large(  url: url ?? this.url,
  width: width ?? this.width,
  height: height ?? this.height,
  size: size ?? this.size,
  thumbnail: thumbnail ?? this.thumbnail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['size'] = size;
    map['thumbnail'] = thumbnail;
    return map;
  }
}