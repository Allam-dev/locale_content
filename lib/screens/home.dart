import 'package:flutter/material.dart';
import 'package:mosta/core/widgets/click_gif.dart';
import 'package:mosta/core/extensions.dart';
import 'package:video_player/video_player.dart';

import '../core/assets.dart';
import 'details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.homeVideo)
      ..initialize().then((value) => {setState(() {})});
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
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
                top: context.ofSH(0.445),
                right: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context) => const DetailsScreen()))
                        .then((value) => _controller.play());
                  },
                  child: Image.asset(Assets.homeButton,height: context.ofSH(0.1),),
                ),
              ),
               Positioned(
                top: context.ofSH(0.5),
                right: 0,
                left: 0,
                child: ClickGif(
                  height: context.ofSH(0.1),
                ),
              ),
            ],
          )
              : const SizedBox.shrink(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
