import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdv_app/model/order.dart';
import 'package:pdv_app/provider/taker_provider.dart';
import 'package:pdv_app/utils/colors_theme.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 5,
                  color: ColorsTheme.primary800,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        'R\$ ${widget.order.total!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.orderTime),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Text(
                    'Metodo de pagamento: ${widget.order.paymentTypeString}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (widget.order.takerId != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 4,
                      bottom: 14,
                    ),
                    child: Text(
                      'Tomador: ${Provider.of<TakerProvider>(context, listen: false).takerName(widget.order.takerId!)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  height: (widget.order.sales!.length * 25) + 20,
                  child: ListView(
                    children: widget.order.sales!
                        .map(
                          (sale) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                sale.product!.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${sale.getQuantity}x R\$ ${sale.product!.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
