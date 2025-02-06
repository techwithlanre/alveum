
import 'package:alveum/app/modules/home/views/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class VideoFeed extends GetView<HomeController> {
  const VideoFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          return PageView.builder(
            controller: controller.pageController,
            scrollDirection: Axis.vertical,
            itemCount: controller.allPosts.length,
            onPageChanged: (index) {
              //controller.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Text(controller.allPosts[index].videos!.large!.url!),
                  VideoPlayerWidget(
                    post: controller.allPosts[index],
                  )
                ],
              );
            },
          );
        })
    );
  }
}
