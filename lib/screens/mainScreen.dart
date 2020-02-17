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
          final user = json.decode(snapshot.data.toString());

          return _mainPageBody(user);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _mainPageBody(user) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _head(),
          _statusOptions(),
          _playerStats(user),
        ],
      ),
    );
  }

  Widget _playerStats(user) {
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
                _playerStatsItem(
                    'Played',
                    (user['totals']['wins'] + user['totals']['losses'])
                        .toString()),
                _playerStatsItem('Won', user['totals']['wins'].toString()),
                _playerStatsItem('Won', user['totals']['losses'].toString()),
                _playerStatsTitle('PLAYER KILLS'),
                _playerStatsItem('Kills', user['totals']['kills'].toString()),
                _playerStatsItem('Deaths', user['totals']['deaths'].toString()),
                _playerStatsItem(
                    'Assists', user['totals']['assists'].toString()),
                _playerStatsTitle('OBJECTIVES'),
                _playerStatsItem('Credits', user['totals']['gold'].toString()),
                _playerStatsTitle('DAMAGE'),
                _playerStatsItem('Player', user['totals']['damage'].toString()),
                _playerStatsItem(
                    'Team Healing', user['totals']['healing'].toString()),
                _playerStatsItem(
                    'Self Healing', user['totals']['self_healing'].toString()),
                _playerStatsItem(
                    'Weapon', user['totals']['in_hand'].toString()),
                _playerStatsItem(
                    'Shielding', user['totals']['mitigated'].toString()),
                _playerStatsItem('Taken', user['totals']['taken'].toString()),
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
