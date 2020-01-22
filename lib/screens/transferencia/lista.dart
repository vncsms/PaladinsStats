import 'package:flutter/material.dart';
import 'package:paladins_stats_app/models/transferencia.dart';
import 'package:paladins_stats_app/screens/transferencia/formulario.dart';

class Listatransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

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
        title: Text('Transferencaiass'),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {

            final transferencia = widget._transferencias[indice];
            return Itemtransferencia(transferencia);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: Icon(Icons.add),
      ),
    );
  }

/*  Widget _construirHome() {
    return Scaffold(
        body: SizedBox(
            child: FutureBuilder(
              future: DefaultAssetBundle
                  .of(context)
                  .loadString('assets/receitas.json'),
              builder: (context, snapshot) {
                List<dynamic> receitas = json.decode(snapshot.data.toString());

                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Receita receita = Receita.fromJson(receitas[index]);
                    return _construirCard(receita.foto, receita.titulo);
                  },
                  itemCount: receitas == null ? 0 : receitas.length,
                );
              },
            )
        ),
        appBar: _construirAppBar('Cozinhando em Casa')
    );
  }*/

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class Itemtransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  Itemtransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff0e343c),
      child: ListTile(
        leading: Image.network('https://web2.hirez.com/paladins/champion-icons/ash.jpg'),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
