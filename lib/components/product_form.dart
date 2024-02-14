import 'package:flutter/material.dart';
import 'package:pdv_app/model/product.dart';
import '../data/category_data.dart';
import '../model/category.dart';

class ProductForm extends StatefulWidget {
  final Function(String, String, int, double, double, Category) onSubmit;
  final bool isEditing;
  final Product? product;

  const ProductForm({super.key, required this.onSubmit, this.isEditing = false,this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late TextEditingController _nameController;
  late TextEditingController _barcodeController;
  late TextEditingController _stockUnitController;
  late TextEditingController _priceController;
  late TextEditingController _costPriceController;
  late bool isEditing;

  late Category _selectedCategory;

  int get indexCategory{
    return categoryData.indexWhere((element) => element.id == widget.product?.categoria.id);
  }

  @override
  void initState() {
    super.initState();
    _nameController = widget.isEditing?TextEditingController(text: widget.product?.nome):TextEditingController();
    _barcodeController = widget.isEditing?TextEditingController(text: widget.product?.cod_barras):TextEditingController();
    _stockUnitController = widget.isEditing?TextEditingController(text: widget.product?.unidade.toString()):TextEditingController();
    _priceController = widget.isEditing?TextEditingController(text: widget.product?.preco.toString()):TextEditingController();
    _costPriceController = widget.isEditing?TextEditingController(text: widget.product?.preco_custo.toString()):TextEditingController();
    _selectedCategory = widget.isEditing?categoryData[indexCategory]:categoryData[0];
    isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Nome",
                    ),
                    controller: _nameController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Cod. Barras",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _barcodeController,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Un. Estoque",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _stockUnitController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Preço",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _priceController,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Preço de Custo",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _costPriceController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categoria",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButton<Category>(
                            isExpanded: true,
                            alignment: Alignment.center,
                            menuMaxHeight:
                                MediaQuery.of(context).size.height * 0.3,
                            elevation: 4,
                            value: _selectedCategory,
                            items: categoryData.map<DropdownMenuItem<Category>>(
                              (Category category) {
                                return DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.name),
                                );
                              },
                            ).toList(),
                            onChanged: (Category? newValue) {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          widget.onSubmit(
                            _nameController.text,
                            _barcodeController.text,
                            int.parse(_stockUnitController.text),
                            double.parse(_priceController.text),
                            double.parse(_costPriceController.text),
                            _selectedCategory,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          isEditing?"Editar Produto":"Criar Produto",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
