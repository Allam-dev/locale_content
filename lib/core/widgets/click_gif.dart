import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:mosta/core/assets.dart';

class ClickGif extends StatefulWidget {
  final double? height;

  const ClickGif({super.key, this.height});

  @override
  State<ClickGif> createState() => _ClickGifState();
}

class _ClickGifState extends State<ClickGif> {
  bool show = false;
  final _controller = GifController(
    loop: false,
  );

  @override
  void initState() {
    super.initState();
    toggle();
  }

  toggle() async {
    while (true) {
      if (show) {
        setState(() {
          show = false;
        });
        await Future.delayed(const Duration(seconds: 20));
      } else {
        setState(() {
          show = true;
        });
        for (int i = 0; i < 3; i++) {
          _controller.play(initialFrame: 0);
          await Future.delayed(const Duration(milliseconds: 4370));
          _controller.stop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? GifView.asset(
            Assets.clickGif,
            controller: _controller,
            height: widget.height,
          )
        : const SizedBox.shrink();
  }
}
