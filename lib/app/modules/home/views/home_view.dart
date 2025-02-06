import 'package:alveum/app/modules/home/views/partials/feeds_view.dart';
import 'package:alveum/app/modules/home/views/partials/image_feed.dart';
import 'package:alveum/app/modules/home/views/partials/video_feed.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Feeds'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(() => _pages.elementAt(controller.selectedPageIndex.value)),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: controller.selectedPageIndex.value,
            onTap: (index) {
              controller.selectedPageIndex.value = index;
            },
            items: _navigationItems()
        );
      }),

    );
  }

  static final List<Widget> _pages = <Widget>[
    FeedsView(),
    Center(
      child: Icon(
        Icons.chat,
        size: 150,
      ),
    ),
    Center(
      child: Icon(
        Icons.chat,
        size: 150,
      ),
    ),
  ];

  List<BottomNavigationBarItem> _navigationItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Pictures'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.video_library),
        label: 'Videos',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.perm_media_rounded),
        label: 'All Media',
      ),
    ];
  }
}
