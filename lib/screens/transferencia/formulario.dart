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
}

Widget _championDetail(champion) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _avatarPage(champion),
        _titlePage(champion),
      ],
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
