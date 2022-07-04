import 'dart:convert';
import 'package:coins/View/info_view.dart';
import 'package:coins/Component/animated_text_widget.dart';
import 'package:coins/Component/my_drawer.dart';
import 'package:coins/Component/splash.dart';
import 'package:coins/Model/coin_model.dart';
import 'package:coins/Model/temp_model.dart';
import 'package:coins/View/currencies_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CoinModel> coins = [];
  double totalPrice = 0;


  void getDataFromApi() async{
    String Url = 'https://www.cryptingup.com/api/assets';
    var response = await http.get(Url);
    var dataParsed = jsonDecode(response.body);

    setState(() {
      for(int i = 0; i < 99; i++){
        coins.add(
          CoinModel(
            name: dataParsed['assets'][i]['name'],
            id: dataParsed['assets'][i]['asset_id'],
            volume_24h: dataParsed['assets'][i]['volume_24h'].runtimeType == double ? dataParsed['assets'][i]['volume_24h'] : 0.0,
            price: dataParsed['assets'][i]['price'],
            time: dataParsed['assets'][i]['updated_at'],
            change_24h: dataParsed['assets'][i]['change_24h'].runtimeType == double ? dataParsed['assets'][i]['change_24h'] : 0.0,
            change_1h: dataParsed['assets'][i]['change_1h'].runtimeType == double ? dataParsed['assets'][i]['change_1h'] : 0.0,
            change_7d: dataParsed['assets'][i]['change_7d'].runtimeType == double ? dataParsed['assets'][i]['change_7d'] : 0.0,
            totalPrice: totalPrice + dataParsed['assets'][i]['price'],
          )
        );
      }
    });
  }

  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }
  @override


  Widget build(BuildContext context) {
    return coins.length == 0
    ? Splash()
    : Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Coins'),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.redoAlt, size: 20,),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.questionCircle),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView()));
              },
            )
          ],
        ),
        backgroundColor: Color(0xFF5F627D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: AnimatedTextWidget(),
                margin: EdgeInsets.only(bottom: 24),
                width: double.infinity,
                height: 190,
                padding: EdgeInsets.all(8),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last Updated ${coins[0].time.split('T')[1]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.searchDollar,
                      size: 18,
                    ),
                    color: Colors.white,
                    onPressed: (){
                      showSearch(
                        context: context,
                        delegate: SearchPage<CoinModel>(
                          barTheme: ThemeData(
                            primaryColor: Color(0xFF5F627D),
                          ),
                          items: coins,
                          searchLabel: 'Search coin',
                          suggestion: Center(
                            child: Text('Filter coin by name'),
                          ),
                          failure: Center(
                            child: Text('No coin found'),
                          ),
                          filter: (coin) => [
                            coin.name,
                            coin.id
                          ],
                          builder: (coin) => ListTile(
                            title: Text(coin.name),
                            subtitle: Text(coin.id),
                            leading: Container(
                              child: Image.asset(
                                'assets/${coin.id}.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 20,
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrenciesView(
                                  TempModel(
                                    name: coin.name,
                                    id: coin.id,
                                    time: coin.time,
                                    volume_24h: coin.volume_24h,
                                    change_24h: coin.change_24h,
                                    change_1h: coin.change_1h,
                                    change_7d: coin.change_7d,
                                    price: coin.price,
                                    totalPrice: coin.totalPrice
                                  )
                              )));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: coins.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CurrenciesView(
                              TempModel(
                                name: coins[index].name,
                                id: coins[index].id,
                                time: coins[index].time,
                                volume_24h: coins[index].volume_24h,
                                change_24h: coins[index].change_24h,
                                change_1h: coins[index].change_1h,
                                change_7d: coins[index].change_7d,
                                price: coins[index].price,
                                totalPrice: coins[index].totalPrice
                              )
                          ) ));
                        },
                        leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF5B300),
                            ),
                            child: Image.asset(
                              'assets/${coins[index].id}.png',
                              width: 50,
                              height: 50,
                            )
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                coins.length == 0
                                    ? CircularProgressIndicator()
                                    :coins[index].name == ''
                                    ? Text(
                                  '${coins[index].id}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                                 : Text(
                                  '${coins[index].name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Text(
                                  '\$${coins[index].price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${coins[index].time.split('T')[0]}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  coins[index].change_24h.toString().contains('-')
                                      ? Row(
                                    children: [
                                      Text(
                                        '${coins[index].change_24h.toStringAsFixed(2)}%',
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
                                        '${coins[index].change_24h.toStringAsFixed(2)}%',
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
                            ),
                          ],
                        ),
                      );
                    }

                ),
              )
            ],
          ),
        ),

    );
  }
}

