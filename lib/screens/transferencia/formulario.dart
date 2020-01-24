import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paladins_stats_app/components/editor.dart';
import '../../models/champion.dart';

class FormularioTransferencia extends StatefulWidget {
  final Champion champion;

  const FormularioTransferencia({Key key, this.champion}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.champion.feName),
      ),
      body: FutureBuilder(
        future: fetchPost(),
        builder: (context, snapshot){
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Editor(
                    controlador: _controladorCampoNumeroConta,
                    rotulo: 'Numero da conta',
                    dica: '000'),
                Editor(
                    controlador: _controladorCampoValor,
                    rotulo: 'Valor',
                    dica: '0.00',
                    icone: Icons.monetization_on),
              ],
            ),
          );
        },
      )
    );
  }
  fetchPost() async {
    final response =
    await http.get('https://cms.paladins.com/wp-json/wp/v2/champions?slug=dredge&lang_id=1');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      debugPrint(response.body);
      return null;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
