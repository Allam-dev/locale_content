import 'package:flutter/material.dart';
import 'package:mosta/core/assets.dart';
import 'package:mosta/core/extensions.dart';
import 'package:video_player/video_player.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.detailsVideo)
      ..initialize().then((value) => {setState(() {})});
    _controller.setVolume(0.0);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Scaffold(
        body: _controller.value.isInitialized
            ? Stack(
                children: [
                  Center(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.ofSH(0.4),
                    bottom: context.ofSH(0.0006),
                    right: context.ofSW(1.09),
                    left: context.ofSW(0.8995),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(Assets.backButton,
                          width: MediaQuery.sizeOf(context).width * 0.01,
                          height: MediaQuery.sizeOf(context).height * 0.01),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
