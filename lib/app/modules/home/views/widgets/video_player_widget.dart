import 'package:alveum/app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Post post;

  const VideoPlayerWidget({super.key, required this.post});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}


class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isControlsVisible = true;
  bool _isMuted = false;
  bool _isInitialized = false; 
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (widget.post.videos != null && widget.post.videos!.small != null && widget.post.videos!.small!.url != null) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.post.videos!.small!.url!),
      );

      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        setState(() {
          _isInitialized = true; 
          _controller.setLooping(true);
          _controller.setVolume(0.6);
          _controller.play();
        });
      }).catchError((error) {
        print("Error initializing video: $error");
        
        setState(() {}); 
      });

      _controller.addListener(_videoListener); 
    } else {
      
      _isInitialized = false;
    }
  }


  void _videoListener() {
    if (_controller.value.isPlaying) {
      setState(() {
        _currentPosition = _controller.value.position;
      });
    }
  }


  @override
  void dispose() {
    _controller.removeListener(_videoListener); 
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 0.6); 
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(
        child: Skeletonizer(
          enabled: true,
          child: Container(
            height: 420,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
          ),
        ),
      );
    }

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isControlsVisible = !_isControlsVisible;
              });
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: VideoPlayer(_controller),
                  ),
                ),
                _buildControlsOverlay(), 
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator()); 
        }
      },
    );
  }

  Widget _buildControlsOverlay() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: _isControlsVisible
          ? Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(
                    !_isMuted ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                  onPressed: _toggleMute,
                ),
              ],
            ),
          ),
        ],
      )
          : const SizedBox(),
    );
  }
}