import 'dart:convert';
import 'dart:math';
import 'package:coins/Component/my_list_tile_convertor_widget.dart';
import 'package:coins/Component/my_list_tile_info_widget.dart';
import 'package:coins/Component/splash.dart';
import 'package:coins/Model/exchange_rate_model.dart';
import 'package:coins/Model/temp_model.dart';
import 'package:coins/Service/calculator.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:http/http.dart' as http;

class CurrenciesView extends StatefulWidget {

  TempModel tempModel;
  CurrenciesView(this.tempModel);

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  _CurrenciesViewState createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  ExchangeRateModel exchangeRateModel = ExchangeRateModel();

  void getDataFromExchangeRateApi() async{
    String Url = 'https://api.exchangerate-api.com/v4/latest/USD';
    var response = await http.get(Url);
    var dataParsed = jsonDecode(response.body);

    setState(() {
      exchangeRateModel.Usd = dataParsed['rates']['USD'];
      exchangeRateModel.Eur = dataParsed['rates']['EUR'];
      exchangeRateModel.Gbp = dataParsed['rates']['GBP'];
      exchangeRateModel.Jpy = dataParsed['rates']['JPY'];
      exchangeRateModel.date = dataParsed['date'];

    });
  }

  final PageController _pageController = PageController();
  double _currentPosition = 0;

  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  double coinPercentage;


  bool isPlaying = false;
  @override
  void initState() {
    getDataFromExchangeRateApi();
    coinPercentage = Calculator.RateCalculation(widget.tempModel.volume_24h, widget.tempModel.totalPrice);


    _pageController.addListener(() {
      _currentPosition = _pageController.page;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return exchangeRateModel.date == null
        ? Splash()
        : Scaffold(
        backgroundColor: Color(0xFF5F627D),
        appBar: _currentPosition == 0
            ? AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: widget.tempModel.name == ''
              ? Text('${widget.tempModel.id}')
              : Text('${widget.tempModel.name}'),
        )
            : AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Exchange Rate'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DotsIndicator(
                  dotsCount: 2,
                  position: _currentPosition,
                  decorator: DotsDecorator(
                    activeColor: Colors.white,
                    size: Size(4, 4),
                  ),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY(pi * _currentPosition),
                child: Container(
                  margin: EdgeInsets.only(bottom: 24),
                  width: double.infinity,
                  height: 190,
                  padding: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _currentPosition == 0
                        ? RadarChart(
                      values: [
                        widget.tempModel.change_1h * 0.1 >= 10 ? 3 : widget.tempModel.change_1h * 0.1,
                        widget.tempModel.change_24h * 0.1 >= 10 ? 3 : widget.tempModel.change_24h * 0.1,
                        widget.tempModel.change_7d * 0.1 >= 10 ? 3 : widget.tempModel.change_7d * 0.1
                      ],
                      labels: [
                        "Change 1h",
                        "Change 24h",
                        "Change 7d",
                      ],
                      maxValue: 10,
                      fillColor: Colors.red,
                      labelColor: Colors.black,
                      chartRadiusFactor: 0.7,
                    )
                        :Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(pi * _currentPosition),
                          child: PieChart(
                            size: MediaQuery.of(context).size * 0.7,
                      values: [100-coinPercentage, coinPercentage],
                      labels: ["${widget.tempModel.id}", "Others"],
                      sliceFillColors: [
                          Colors.blueAccent,
                          Colors.pink,
                      ],
                      animationDuration: Duration(milliseconds: 1500),
                      legendPosition: LegendPosition.Right,
                    ),
                        ),
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        color: Colors.black54,
                        spreadRadius: -5,
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF08AEEA),
                        Color(0xFF2AF598),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 2,
                  itemBuilder: (context, index) => _currentPosition == 0
                      ? Container(
                    child: Column(
                      children: [
                        MyListTileInfoWidget(widget: widget,title: 'Volume', value: widget.tempModel.volume_24h,),
                        MyListTileInfoWidget(widget: widget,title: 'Change 1h', value: widget.tempModel.change_1h,),
                        MyListTileInfoWidget(widget: widget,title: 'Change 24h', value: widget.tempModel.change_24h,),
                        MyListTileInfoWidget(widget: widget,title: 'Change 7d', value: widget.tempModel.change_7d,),
                      ],
                    ),
                  )
                  :Container(
                    child: Column(
                      children: [
                        MyListTileConvertorWidget(widget: widget,title: 'USD', value: widget.tempModel.price,unit: '\$',),
                        MyListTileConvertorWidget(widget: widget,title: 'EUR', value: Calculator.UsdToEur(widget.tempModel.price,exchangeRateModel.Eur),unit: '€',),
                        MyListTileConvertorWidget(widget: widget,title: 'JPY', value: Calculator.UsdToJpy(widget.tempModel.price,exchangeRateModel.Jpy),unit: '¥',),
                        MyListTileConvertorWidget(widget: widget,title: 'GBP', value: Calculator.UsdToGBP(widget.tempModel.price,exchangeRateModel.Gbp),unit: '£',),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}


