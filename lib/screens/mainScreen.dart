import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paladins_stats_app/services/userService.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int selectedStatus = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: getStatus(),
    );
  }

  Widget getStatus() {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _mainPageBody();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
                _playerStatsTitle('MATCHES'),
                _playerStatsItem('Played', '1,711'),
                _playerStatsItem('Won', '931'),
                _playerStatsItem('Played', '1,711'),
                _playerStatsTitle('PLAYER KILLS'),
                _playerStatsItem('KDA', '284'),
                _playerStatsItem('Kills', '5,216,290'),
                _playerStatsItem('Deaths', '3,668m 35s'),
                _playerStatsItem('Assists', '3,668m 35s'),
                _playerStatsTitle('OBJECTIVES'),
                _playerStatsItem('CPM', '284'),
                _playerStatsItem('Credits', '5,216,290'),
                _playerStatsItem('Objective Time', '3,668m 35s'),
                _playerStatsTitle('DAMAGE'),
                _playerStatsItem('Player', '284'),
                _playerStatsItem('Team Healing', '5,216,290'),
                _playerStatsItem('Self Healing', '3,668m 35s'),
                _playerStatsItem('Weapon', '3,668m 35s'),
                _playerStatsItem('Shielding', '3,668m 35s'),
                _playerStatsItem('Taken', '3,668m 35s'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playerStatsItem(title, value) {
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

  Widget _playerStatsTitle(title) {
    return Container(
      color: HexColor('#3183c8'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
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

  Widget _optionMode(title, number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = number;
        });
      },
      child: Card(
        color: selectedStatus == number
            ? HexColor('#4d648d')
            : HexColor('#3183c8'),
        child: Container(
          width: 150.0,
          height: 80.0,
          child: Center(
            child: Text(title),
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
            _optionMode('Summary', 1),
            _optionMode('Casual', 2),
            _optionMode('Ranked', 3),
            _optionMode('Champions', 4),
            _optionMode('Matchs', 5),
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
