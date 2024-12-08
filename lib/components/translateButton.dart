import 'package:flutter/material.dart';

class translateButton extends StatelessWidget {
  const translateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: FittedBox(
        child: FloatingActionButton.large(
          onPressed: null,
          shape: CircleBorder(),
          backgroundColor: Color(0xff4749AE),
          child: Image.asset('assets/icons/translate.png', height: 55,)
          ),
      ),
    );
  }
}
