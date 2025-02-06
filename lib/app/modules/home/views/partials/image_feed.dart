import 'package:alveum/app/global_widgets/image_loader.dart';
import 'package:alveum/app/modules/home/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../models/post.dart';

class ImageFeed extends GetView<HomeController> {
  const ImageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _imagePostWidget()
        ]
      )
    );
  }

  Widget _imagePostWidget() {
    return Expanded(
      child: Obx(() => ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.allPosts.length,
          itemBuilder: (context, index) {
            final Post post = controller.allPosts[index];
            if (controller.allPosts.isEmpty && controller.isFetching.value) {
              return const Center(child: ImageLoader());
            }

            ////controller.prefetchNextImages(index);
            //controller.prefetchNextVideos(index);

            return post.type == 'film' ? Container() : ListTile(
              title: Container(
                width: Get.width,
                height: Get.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: post.largeImageURL!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: ImageLoader(), // Preloader
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey), // Error widget
                  ),
                ),
              ),
              subtitle: Text('Likes: ${post.likes} - Views: ${post.views}'),
              onTap: () {
                Get.snackbar('Post', 'Tapped post with id: ${post.id}');
              },
            );
          }
      )),
    );
  }
}
