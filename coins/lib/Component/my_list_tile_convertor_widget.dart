import 'package:coins/View/currencies_view.dart';
import 'package:flutter/material.dart';

class MyListTileConvertorWidget extends StatelessWidget {

  final CurrenciesView widget;
  final title;
  final value;
  final unit;
  MyListTileConvertorWidget({@required this.widget,this.title,this.value,this.unit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                '${value.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}