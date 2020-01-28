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
            debugPrint('oloco');
            final champion = json.decode(snapshot.data.toString());
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.network(
                      'https://web2.hirez.com/paladins/champion-headers/' +
                          champion[0]['slug'] +
                          '.png'),
                ],
              ),
            );
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
