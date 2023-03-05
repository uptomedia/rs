import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:rs/src/global/models/courses/lesson.dart';
import 'package:rs/src/global/utils/config.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  late final ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    print("${AppConfig.baseUrl}/${widget.lesson.video_url}");
    _controller = VideoPlayerController.network(
        "${AppConfig.baseUrl}/${widget.lesson.video_url}");

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      controlsSafeAreaMinimum: const EdgeInsets.all(5),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(),
          body: Center(
              child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          )),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     setState(() {
          //       _controller.value.isPlaying
          //           ? _controller.pause()
          //           : _controller.play();
          //     });
          //   },
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //   ),
          // ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
