import 'package:flutter/material.dart';

class CategoryCreateForm extends StatefulWidget {
  void Function(String) submitForm;

  CategoryCreateForm({super.key, required this.submitForm});

  @override
  _CategoryCreateFormState createState() => _CategoryCreateFormState();
}

class _CategoryCreateFormState extends State<CategoryCreateForm> {
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Nome da Categoria"),
              controller: _valueController,
              onSubmitted: (_) => widget.submitForm(_valueController.text),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      widget.submitForm(_valueController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "Criar Categoria",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
