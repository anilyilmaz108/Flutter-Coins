import 'package:animations/animations.dart';
import 'package:coins/Component/dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF5F627D),
                  Color(0xFF313347),
                ]
            )
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/btc.gif',
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.envelope),
                title: Text('anilyilmaz108@gmail.com',),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.github),
                title: Text('anilyilmaz108'),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.instagram),
                title: Text('anil.yilmz'),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.linkedin),
                title: Text('Anıl Yılmaz'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: RichText(
                    text: TextSpan(

                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                      text: "Terms & Conditions ",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
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
                        TextSpan(
                          text: "| ",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        TextSpan(
                          text: "Privacy Policy!",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
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
                      ]
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

