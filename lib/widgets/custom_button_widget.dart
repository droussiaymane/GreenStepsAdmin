import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButtonWidget extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final String value;
  final String groupValue;
  const CustomButtonWidget(
      {Key? key,
      required this.child,
      this.onTap,
      required this.value,
      required this.groupValue})
      : super(key: key);

  @override
  _CustomButtonWidgetState createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  Color inactiveColor = kLightPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isOnHover) {
        if (isOnHover) {
          setState(() {
            inactiveColor = kPrimaryColor;
          });
        } else {
          setState(() {
            inactiveColor = kLightPrimaryColor;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (widget.value == widget.groupValue)
              ? kPrimaryColor
              : inactiveColor,
        ),
        height: 60,
        child: widget.child,
      ),
    );
  }
}
