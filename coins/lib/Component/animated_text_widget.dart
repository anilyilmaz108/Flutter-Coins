import 'package:animated_text/animated_text.dart';
import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: AnimatedText(
              repeatCount: 3,
              alignment: Alignment.center,
              speed: Duration(milliseconds: 1000),
              controller: AnimatedTextController.loop,
              displayTime: Duration(milliseconds: 1000),
              wordList: ['Tether', 'Bitcoin', 'Ethereum', 'Dogecoin'],
              textStyle: TextStyle(
                  color: Colors.blueGrey.shade400,
                  fontSize: 55,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
