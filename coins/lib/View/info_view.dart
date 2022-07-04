import 'package:animations/animations.dart';
import 'package:coins/Component/dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/crypto.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                    children: [
                      Text('Coins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "By downloading the app, you are agreeing to our\n",
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: "Terms & Conditions ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showModal(
                                      context: context,
                                      configuration: FadeScaleTransitionConfiguration(),
                                      builder: (context) {
                                        return PolicyDialog(
                                          mdFileName: 'terms_and_conditions.md',
                                        );
                                      },
                                    );
                                  },
                              ),
                              TextSpan(text: "| "),
                              TextSpan(
                                text: "Privacy Policy!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PolicyDialog(
                                          mdFileName: 'privacy_policy.md',
                                        );
                                      },
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                        Navigator.of(context).pop();
                      },
                        child: Text('Ok', style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -60,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow[800],
                    radius: 60,
                    child: Icon(FontAwesomeIcons.bitcoin, color: Colors.white, size: 60,),
                  )
              ),
            ],
          )
      ),
    );
  }
}

