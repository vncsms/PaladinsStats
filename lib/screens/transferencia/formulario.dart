import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/champion.dart';

class FormularioTransferencia extends StatefulWidget {
  final Champion champion;

  const FormularioTransferencia({Key key, @required this.champion})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  String selected = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.champion.feName),
        ),
        body: FutureBuilder(
          future: fetchPost(widget.champion.feName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final champion = json.decode(snapshot.data.toString());
              return _championDetail(champion);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  fetchPost(championName) async {
    final response = await http.get(
        'https://cms.paladins.com/wp-json/wp/v2/champions?slug=' +
            championName.replaceAll(' ', '-').toLowerCase() +
            '&lang_id=1');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Widget _championDetail(champion) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _avatarPage(champion),
          _titlePage(champion),
          _titleTopic('talents', 30.0),
          _legendaries(champion),
          _titleTopic('abilites', 45.0),
          _abilites(champion),
          _abiliteDetails(champion),
        ],
      ),
    );
  }

  Widget _abiliteDetails(champion) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Text(
              champion[0]['api_information']['Ability_' + selected]['Summary'],
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        Image.asset('assets/images/bottom-border.png'),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(champion[0]['api_information']['Ability_' + selected]
              ['Description']),
        ),
      ],
    );
  }

  Widget _abilites(champion) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = '1';
                });
                debugPrint(selected);
              },
              child: _abilityIcon(champion, '1'),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = '2';
                });
                debugPrint(selected);
              },
              child: _abilityIcon(champion, '2'),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = '3';
                });
                debugPrint(selected);
              },
              child: _abilityIcon(champion, '3'),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = '4';
                });
                debugPrint(selected);
              },
              child: _abilityIcon(champion, '4'),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = '5';
                });
                debugPrint(selected);
              },
              child: _abilityIcon(champion, '5'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _abilityIcon(champion, index) {
    var colorBorder =
        index == selected ? const Color(0x547a8c00) : const Color(0x00000000);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 10.0, color: colorBorder),
          left: BorderSide(width: 10.0, color: colorBorder),
          right: BorderSide(width: 10.0, color: colorBorder),
          bottom: BorderSide(width: 10.0, color: colorBorder),
        ),
      ),
      child: Image.network(
          champion[0]['api_information']['Ability_' + index]['URL']),
    );
  }

  Widget _titleTopic(title, size) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(title.toUpperCase(), style: TextStyle(fontSize: size)),
    );
  }

  Widget _legendaries(champion) {
    final cards = [];
    for (var card in champion[0]['cards']) {
      if (card['rarity'] == 'Legendary') {
        cards.add(card);
      }
    }
    return SizedBox(
      height: 550.0,
      child: ListView.builder(
          primary: false,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 16),
              child: _legendaryCard(cards[index]),
            );
          }),
    );
  }

  Widget _legendaryCard(card) {
    String card_name =
        'https://web2.hirez.com/paladins/champion-legendaries-badge/' +
            card['card_name_english'].toLowerCase().replaceAll(' ', '-') +
            '.png';

    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4, // 20%
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.network(card_name, scale: 1),
                ),
              ),
              Expanded(
                flex: 6, // 20%
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 20.0, top: 0, bottom: 16),
                      child: Text(card['card_name_english'].toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Text(
                          card['card_description']
                              .replaceAll(new RegExp(r'\[.*?\] '), ''),
                          style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarPage(champion) {
    return Stack(children: <Widget>[
      Image.network('https://web2.hirez.com/paladins/champion-headers/' +
          champion[0]['slug'] +
          '.png'),
      Positioned(
        bottom: 20.0,
        left: 20.0,
        child: _chooseIcon(champion),
      )
    ]);
  }

  Widget _chooseIcon(champion) {
    String role = champion[0]['api_information']['Roles'].toLowerCase();
    if (role.contains('front')) {
      return Image.asset('assets/images/front.png', width: 70, height: 70);
    } else if (role.contains('flanker')) {
      return Image.asset('assets/images/flank.png', width: 70, height: 70);
    } else if (role.contains('damage')) {
      return Image.asset('assets/images/damage.png', width: 70, height: 70);
    } else if (role.contains('support')) {
      return Image.asset('assets/images/support.png', width: 70, height: 70);
    } else {
      return null;
    }
  }

  Widget _titlePage(champion) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
              champion[0]['api_information']['Name_English'].toUpperCase(),
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        Container(
          child: Text(champion[0]['api_information']['Title'].toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                color: HexColor(champion[0]['frontend_info']['color_picker']),
              )),
        ),
        Container(
          child: Text(
              champion[0]['frontend_info']['role']
                  .replaceAll('Paladins', '')
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                color: HexColor('#547a8c'),
              )),
        ),
      ],
    );
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
