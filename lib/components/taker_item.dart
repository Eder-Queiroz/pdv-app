import 'package:flutter/material.dart';
import 'package:pdv_app/model/taker.dart';

class TakerItem extends StatelessWidget {
  final Taker taker;
  final Function(Taker?) openShiftModal;
  const TakerItem(
      {super.key, required this.taker, required this.openShiftModal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 80,
          height: 40,
          child: Card(
            color: Theme.of(context).colorScheme.primary,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('R\$${taker.total_price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
        title: Text(
          taker.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(taker.phone),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => openShiftModal(taker),
        ),
      ),
    );
  }
}
