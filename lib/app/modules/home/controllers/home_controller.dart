import 'dart:convert';
import 'dart:isolate';
import 'package:alveum/app/helpers/api_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import '../../../models/post.dart';

class HomeController extends GetxController {
  PageController pageController = PageController(initialPage: 0, viewportFraction: 1);

  final RxInt selectedPageIndex = 0.obs;
  final RxList<Post> allPosts = <Post>[].obs;
  RxBool isFetching = false.obs;
  final ScrollController scrollController = ScrollController();
  int currentPostPage = 1;
  int perPage = 5;
  late Box postsBox;
  bool _hasMoreImages = true;
  bool _hasMoreVideos = true;
  final Map<String, VideoPlayerController> videoControllers = {};

  @override
  void onInit() {
    super.onInit();
    postsBox = Hive.box('posts');
    _loadFromCache();
    fetchAllData();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    for (final controller in videoControllers.values) {
      controller.dispose();
    }
    videoControllers.clear();
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 800) {
      fetchAllData();
    }
  }

  void _loadFromCache() {
    final postsData = postsBox.get('posts');
    if (postsData != null) {
      allPosts.assignAll(
        postsData.map((json) => Post.fromJson(Map<String, dynamic>.from(json))).toList(),
      );
    }
  }

  void _saveCache() {
    allPosts.map((post) => post.toJson()).toList();
    if (allPosts.length >= 50) {
      allPosts.removeRange(0, 10);
    }
  }

  Future<void> fetchAllData() async {
    if (!_hasMoreImages && !_hasMoreVideos) return;
    if (isFetching.value) return;

    isFetching.value = true;

    
    await Future.wait([_fetchImages(), _fetchVideos()]);

    currentPostPage++;

    isFetching.value = false;
    allPosts.shuffle();
    allPosts.value = allPosts.toSet().toList();
    print(allPosts.length);
    _saveCache();
  }

  Future<void> _fetchImages() async {
    if (!_hasMoreImages) return;
    final url = '$API_BASE_URL/?key=$API_KEY&image_type=photo&q=technology&pretty=true&per_page=$perPage&page=$currentPostPage';

    try {
      List<Post> newPosts = await Isolate.run(() async {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> hits = data['hits'];
          return hits.map((post) => Post.fromJson(post)).toList();
        }
        return [];
      });
      newPosts.isEmpty ? _hasMoreImages = false : allPosts.addAll(newPosts);
    } catch (e) {
      debugPrint('Failed to load images: $e');
    } finally {

    }
  }

  Future<void> _fetchVideos() async {
    if (!_hasMoreVideos) return;

    final url = '$API_BASE_URL/videos?key=$API_KEY&per_page=$perPage&page=$currentPostPage';

    try {
      List<Post> newPosts = await Isolate.run(() async {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> hits = data['hits'];
          return hits.map((post) => Post.fromJson(post)).toList();
        }
        return [];
      });

      newPosts.isEmpty ? _hasMoreVideos = false : allPosts.addAll(newPosts);
    } catch (e) {
      debugPrint('Failed to load videos: $e');
    } finally {

    }
  }

  void prefetchNextImages(int currentIndex) { 
    for (int i = currentIndex + 1; i < currentIndex + 3 && i < allPosts.length; i++) {
      final item = allPosts[i];
      if (item.type == 'image') {
        precacheImage(CachedNetworkImageProvider(item.largeImageURL!), Get.context!);
      }
    }
  }

  void prefetchNextVideos(int currentIndex) {
    for (int i = currentIndex + 1; i < currentIndex + 3 && i < allPosts.length; i++) {
      final item = allPosts[i];
      final String? videoUrl = item.videos?.large?.url;

      if (item.type == 'film' && videoUrl != null && !videoControllers.containsKey(videoUrl)) {
        final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
        controller.initialize().then((_) {
          videoControllers[videoUrl] = controller;
        }).catchError((e) {
          debugPrint('Error prefetching video: $e');
        });
      }
    }
  }

  /*Future<void> initializeVideoAtIndex(int index) async {
    if (index < 0 || index >= videoPosts.length) return;

    final String? videoUrl = videoPosts[index].videos?.large?.url;
    if (videoUrl == null || videoControllers.containsKey(videoUrl)) return;

    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    try {
      await controller.initialize();
      controller.setLooping(true);
      videoControllers[videoUrl] = controller;

      if (index == currentVideoPage.value) {
        controller.play();
      }

      update();
    } catch (e) {
      debugPrint("Error initializing video at index $index: $e");
    }
  }*/

  void disposeVideoController(String url) {
    if (videoControllers.containsKey(url)) {
      videoControllers[url]?.dispose();
      videoControllers.remove(url);
    }
  }

}
