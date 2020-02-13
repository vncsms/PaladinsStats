import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: _mainPageBody(),
    );
  }

  Widget _mainPageBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _head(),
          _statusOptions(),
          _playerStats(),
        ],
      ),
    );
  }

  Widget _playerStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: HexColor('#3183c8'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('PLAYER STATS'),
                  ),
                ),
                Container(
                  color: HexColor('#f8f9fa'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'MATCHES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                playerStatsItem('Played', '1,711'),
                playerStatsItem('Won', '931'),
                playerStatsItem('Played', '1,711'),
                Container(
                  color: HexColor('#f8f9fa'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'OBJECTIVES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                playerStatsItem('CPM', '284'),
                playerStatsItem('Credits', '5,216,290'),
                playerStatsItem('Objective Time', '3,668m 35s'),
                Container(
                  color: HexColor('#f8f9fa'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'DAMAGE',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget playerStatsItem(title, value) {
    return Container(
      color: HexColor('#ffffff'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _head() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: const Color(0xff0e343c),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.amberAccent),
                  ),
                  child: Image.network(
                      'https://static.paladins.guru/i/avatars/0.png',
                      height: 70),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.amberAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('picicio',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Text('Brazil - Updated 9 hours ago'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusOptions() {
    return SizedBox(
        height: 80.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Card(
              color: HexColor('#4d648d'),
              child: Container(
                width: 150.0,
                height: 80.0,
                child: Center(
                  child: Text('Summary'),
                ),
              ),
            ),
            Card(
              color: HexColor('#3183c8'),
              child: Container(
                width: 150.0,
                height: 80.0,
                child: Center(
                  child: Text('Ranked'),
                ),
              ),
            ),
            Card(
              color: HexColor('#3183c8'),
              child: Container(
                width: 150.0,
                height: 80.0,
                child: Center(
                  child: Text('Casual'),
                ),
              ),
            ),
            Card(
              color: HexColor('#3183c8'),
              child: Container(
                width: 150.0,
                height: 80.0,
                child: Center(
                  child: Text('Champions'),
                ),
              ),
            ),
            Card(
              color: HexColor('#3183c8'),
              child: Container(
                width: 150.0,
                height: 80.0,
                child: Center(
                  child: Text('Matchs'),
                ),
              ),
            ),
          ],
        ));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
