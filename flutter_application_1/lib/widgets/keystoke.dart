import 'package:flutter/material.dart';
import 'package:flutter_application_1/design.dart';

class Keystroke extends StatelessWidget {
  final String keyStroke;
  final void Function()? onPressed;

  const Keystroke({required this.keyStroke, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (keyStroke == ' ') {
      return ElevatedButton(
        onPressed: null,
        child: Text(keyStroke),
        style: ElevatedButton.styleFrom(
          primary: CustomColors.backgroundColor,
          onPrimary: Colors.transparent,
          shadowColor: CustomColors.backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
          fixedSize: const Size(10, 10),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(
        child: Text(keyStroke),
      ),
      style: ElevatedButton.styleFrom(
        primary: CustomColors.notInWord,
        // onPrimary: Colors.white,
        // shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        fixedSize: const Size(10, 10),
      ),
    );
  }
}
