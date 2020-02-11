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
    return Column(
      children: <Widget>[
        _head(),
      ],
    );
  }

  Widget _head() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: const Color(0xff0e343c),
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network('https://static.paladins.guru/i/avatars/0.png', height: 80),
                ),
              ),
              Column(
                children: <Widget>[
                  Text('picicio',
                      style:
                          TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Text('Brazil - Updated 9 hours ago'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
