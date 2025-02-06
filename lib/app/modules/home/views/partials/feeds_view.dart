import 'package:alveum/app/modules/home/controllers/home_controller.dart';
import 'package:alveum/app/modules/home/views/widgets/video_player_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/image_loader.dart';
import '../../../../models/post.dart';

class FeedsView extends GetView<HomeController> {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(child: _posts()),
        ],
      ),
    );
  }

  Widget _posts() {
    return Obx(() {
      // If no posts and still fetching, show the loader.
      if (controller.allPosts.isEmpty && controller.isFetching.value) {
        return const Center(child: ImageLoader());
      }
      // If no posts and not fetching, show a no-data message.
      if (controller.allPosts.isEmpty) {
        return const Center(child: Text('No posts found.'));
      }
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.allPosts.length,
        itemBuilder: (context, index) {
          final Post post = controller.allPosts[index];
          switch (post.type) {
            case 'photo':
              return _imageWidget(post);
            case 'animation':
              return _eachVideoWidget(post);
            case 'film':
            // You can create a widget for film posts here.
              return Container();
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _eachVideoWidget(Post post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: VideoPlayerWidget(post: post),
    );
  }

  Widget _imageWidget(Post post) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
        width: double.infinity,
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: post.largeImageURL!,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: ImageLoader(), // Preloader widget.
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),
      ),
      onTap: () {
        Get.snackbar('Post', 'Tapped post with id: ${post.id}');
      },
    );
  }
}
