import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/shift.dart';

class ShiftItem extends StatelessWidget {
  final Shift shift;
  final int index;
  final Function(int) onTap;

  const ShiftItem(
      {super.key,
      required this.shift,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(shift.nome),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Horário: ${DateFormat("dd/MM/y").format(shift.inicio)} - ${shift.fim != null ? DateFormat("dd/MM/y").format(shift.fim!) : ""}',
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Card(
                elevation: 2,
                color: shift.status ? Colors.green : Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    '${shift.status ? 'Ativo' : 'Inativo'}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          onTap(index);
        },
      ),
    );
  }
}
