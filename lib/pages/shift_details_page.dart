import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/shift.dart';

class ShiftDetailsPage extends StatelessWidget {
  const ShiftDetailsPage({super.key});

  Widget _createInfo(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shift shift = ModalRoute.of(context)!.settings.arguments as Shift;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Turno'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _createInfo(Icons.account_circle, shift.userId.toString()),
                _createInfo(
                  Icons.access_time,
                  'Inicio: ${DateFormat("dd/MM/y").format(shift.startTime)}',
                ),
                if (shift.endTime != null)
                  _createInfo(
                    Icons.access_time_filled,
                    'Fim: ${DateFormat("dd/MM/y").format(shift.endTime!)}',
                  ),
                _createInfo(Icons.monetization_on,
                    'R\$ ${shift.endCash != null ? (shift.endCash! - shift.startCash).toStringAsFixed(2) : shift.startCash.toStringAsFixed(2)}'),
                // _createInfo(Icons.attach_money,
                //     'Reforço: R\$ ${shift.reforco != null ? shift.reforco!.toStringAsFixed(2) : '0.00'}'),
                // _createInfo(Icons.money_off,
                //     'Sangria: R\$ ${shift.desconto != null ? shift.desconto!.toStringAsFixed(2) : '0.00'}'),
                // Criar changed e salvar no turno os reforços e sangrias feitos.
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 2,
                    color: shift.isOpened ? Colors.green : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        shift.isOpened ? 'Ativo' : 'Inativo',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
