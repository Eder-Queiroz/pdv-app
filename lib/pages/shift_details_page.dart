import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pdv_app/utils/colors_theme.dart';

import '../model/shift.dart';

class ShiftDetailsPage extends StatelessWidget {
  const ShiftDetailsPage({super.key});

  Widget _createInfo(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
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
      backgroundColor: ColorsTheme.primary800,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: <Widget>[
          Transform.flip(
            flipX: true,
            flipY: true,
            child: SvgPicture.asset(
              'assets/images/Vector.svg',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/Vector.svg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 140),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: ColorsTheme.primary500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _createInfo(
                              Icons.account_circle, shift.name ?? 'Sem nome'),
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
                        ],
                      ),
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
          ),
        ]),
      ),
    );
  }
}
