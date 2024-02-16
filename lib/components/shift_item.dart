import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/shift.dart';

class ShiftItem extends StatelessWidget {
  final Shift shift;

  const ShiftItem({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
            shift.userId.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Horário: ${DateFormat('dd/MM/y').format(shift.startTime)} - ${shift.endTime != null ? DateFormat('dd/MM/y').format(shift.endTime!) : ""}',
          ),
          trailing: SizedBox(
            width: 80,
            child: Card(
              color: shift.isOpened ? Colors.green : Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  shift.isOpened ? 'Aberto' : 'Fechado',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
