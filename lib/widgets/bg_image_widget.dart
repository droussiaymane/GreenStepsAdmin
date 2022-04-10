import 'package:flutter/material.dart';

class BgImageWidget extends StatelessWidget {
  const BgImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("bg.jpg"),
          fit : BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white70, BlendMode.lighten),
        ),
      ),
    );
  }
}
