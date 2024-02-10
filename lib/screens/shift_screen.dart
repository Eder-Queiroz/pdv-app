import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/shift_form.dart';
import 'package:pdv_app/components/shift_item.dart';
import 'package:pdv_app/model/shift.dart';
import 'package:pdv_app/functions/open_modal.dart';
import 'package:pdv_app/utils/app_router.dart';

class ShiftScreen extends StatefulWidget {
  final shiftsData;

  const ShiftScreen({super.key, required this.shiftsData});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  late List<Shift> _shiftsData;

  @override
  void initState() {
    super.initState();
    _shiftsData = widget.shiftsData;
  }

  void _submitForm(String saldo) {
    setState(() {
      if (!_isActive()) {
        _shiftsData.add(
          Shift(
            id: Random().nextDouble().toString(),
            nome: "Eder",
            inicio: DateTime.now(),
            saldo: double.parse(saldo),
            status: true,
          ),
        );
      } else {
        var index = _shiftsData.indexWhere((element) => element.status == true);
        _shiftsData[index] = Shift(
          id: _shiftsData[index].id,
          nome: _shiftsData[index].nome,
          inicio: _shiftsData[index].inicio,
          saldo: _shiftsData[index].saldo - double.parse(saldo),
          fim: DateTime.now(),
          status: false,
        );
      }
    });

    Navigator.of(context).pop();
  }

  void _viewShift(int index) {
    Navigator.of(context).pushNamed(
      AppRouter.showShift,
      arguments: _shiftsData[index],
    );
  }

  bool _isActive() {
    final status = _shiftsData.where((element) => element.status == true);
    return status.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
      ),
      drawer: const MainDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.86,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: _shiftsData.length,
          itemBuilder: (ctx, index) {
            return ShiftItem(
              shift: _shiftsData[index],
              index: index,
              onTap: _viewShift,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            _isActive() ? Colors.red : Theme.of(context).primaryColor,
        onPressed: () {
          ;
          OpenModal.openModal(
            context,
            ShiftForm(
              status: _isActive(),
              submitForm: _submitForm,
            ),
          );
        },
        child: Icon(
          _isActive() ? Icons.close : Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
