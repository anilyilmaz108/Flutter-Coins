import 'package:coins/View/currencies_view.dart';
import 'package:flutter/material.dart';

class MyListTileInfoWidget extends StatelessWidget {

  final CurrenciesView widget;
  final title;
  final value;
  MyListTileInfoWidget({@required this.widget,this.title,this.value});

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
          value.toString().contains('-')
              ? Row(
            children: [
              Text(
                '${value.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.red,
              )
            ],
          )
              : Row(
            children: [
              Text(
                '${value.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
              Icon(
                Icons.arrow_drop_up,
                color: Colors.green,
              )
            ],
          ),
        ],
      ),
    );
  }
}

