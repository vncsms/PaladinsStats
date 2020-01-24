import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paladins_stats_app/screens/transferencia/formulario.dart';
import '../../models/champion.dart';

class Listatransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<Listatransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Champions'),
        ),
        body: SizedBox(
          child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/champions.json'),
              builder: (context, snapshot) {
                List<dynamic> champions = json.decode(snapshot.data.toString());
                return ListView.builder(
                    itemCount: champions == null ? 0 : champions.length,
                    itemBuilder: (context, indice) {
                      Champion champion = Champion.fromJson(champions[indice]);
                      return Itemtransferencia(champion);
                    });
              }),
        ));
  }
}

class Itemtransferencia extends StatelessWidget {
  final Champion _champion;

  Itemtransferencia(this._champion);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormularioTransferencia(champion: _champion)));
        },
        child: Card(
          color: const Color(0xff0e343c),
          child: ListTile(
            leading: Image.network(_champion.image, fit: BoxFit.fill),
            title: Text(_champion.name),
            subtitle: Text(_champion.title),
          ),
        ));
  }
}
