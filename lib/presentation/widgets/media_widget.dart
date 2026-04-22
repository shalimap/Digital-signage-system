import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaWidget extends StatefulWidget {
  final String url;
  final String type;

  const MediaWidget({
    super.key,
    required this.url,
    required this.type,
  });

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();

    if (widget.type == "video") {
      controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          setState(() {});
          controller!.play();
          controller!.setLooping(true); 
        });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "image") {
      return SizedBox.expand(
        child: Image.network(
          widget.url,
          fit: BoxFit.cover,
        ),
      );
    } else {
      if (controller != null && controller!.value.isInitialized) {
        return SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller!.value.size.width,
              height: controller!.value.size.height,
              child: VideoPlayer(controller!),
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }
  }
}