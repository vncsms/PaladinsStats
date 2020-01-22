import 'package:flutter/material.dart';
import 'package:paladins_stats_app/components/editor.dart';
import 'package:paladins_stats_app/models/transferencia.dart';

class FormularioTransferencia extends StatefulWidget {
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
        title: Text('Criando transferencia'),
      ),
      body: SingleChildScrollView(
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
            RaisedButton(
              onPressed: () => _criaTransferencia(context),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double numeroValor = double.tryParse(_controladorCampoValor.text);
    if (numeroValor != null && numeroConta != null) {
      final transferenciaCriada = Transferencia(numeroValor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
