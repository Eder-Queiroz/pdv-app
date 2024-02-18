import 'package:flutter/material.dart';
import 'package:pdv_app/model/category.dart';
import 'package:pdv_app/provider/category_provider.dart';
import 'package:pdv_app/provider/supplier_provider.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/product_provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};
  final _imageUrlFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  _onSubmit(bool isUpdate, int? id) {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      final name = _formData['name']!;
      final barCode = _formData['barCode']!;
      final price = double.parse(_formData['price']!);
      final costPrice = double.parse(_formData['costPrice']!);
      final unit = int.parse(_formData['unit']!);
      final urlImage = _formData['urlImage'];
      final categoryId = int.parse(_formData['categoryId']!);
      final supplierId = int.parse(_formData['supplierId']!);

      isUpdate
          ? Provider.of<ProductProvider>(context, listen: false).updateProduct(
              id: id!,
              name: name,
              barCode: barCode,
              price: price,
              costPrice: costPrice,
              unit: unit,
              urlImage: urlImage,
              categoryId: categoryId,
              supplierId: supplierId,
            )
          : Provider.of<ProductProvider>(context, listen: false).createProduct(
              name: name,
              barCode: barCode,
              price: price,
              costPrice: costPrice,
              unit: unit,
              urlImage: urlImage,
              categoryId: categoryId,
              supplierId: supplierId,
            );

      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    final imageUrlController = TextEditingController(text: product?.urlImage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome'),
                        textInputAction: TextInputAction.next,
                        initialValue: product?.name,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Informe um nome válido!';
                          }

                          if (name.length < 3) {
                            return 'Informe um nome com no mínimo 3 caracteres!';
                          }

                          return null;
                        },
                        onSaved: (name) {
                          _formData['name'] = name ?? '';
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Codigo de Barras'),
                              textInputAction: TextInputAction.next,
                              initialValue: product?.barCode,
                              validator: (barCode) {
                                if (barCode!.isEmpty) {
                                  return 'Informe um código de barras válido!';
                                }

                                if (barCode.length < 3) {
                                  return 'Informe um cod. barras com no mínimo 3 caracteres!';
                                }

                                return null;
                              },
                              onSaved: (barCode) {
                                _formData['barCode'] = barCode ?? '';
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Estoque'),
                              textInputAction: TextInputAction.next,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              initialValue: product?.unit.toString(),
                              validator: (unit) {
                                if (unit!.isEmpty ||
                                    int.tryParse(unit) == null) {
                                  return 'Informe um estoque válido!';
                                }

                                if (int.parse(unit) < 1) {
                                  return 'Informe um valor maior que 0!';
                                }

                                return null;
                              },
                              onSaved: (unit) {
                                _formData['unit'] = unit ?? '';
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Preço'),
                              textInputAction: TextInputAction.next,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: product?.price.toStringAsFixed(2),
                              validator: (price) {
                                if (price!.isEmpty ||
                                    double.tryParse(price) == null) {
                                  return 'Informe um preço válido!';
                                }

                                if (double.parse(price) <= 0) {
                                  return 'Informe um valor maior que 0!';
                                }

                                return null;
                              },
                              onSaved: (price) {
                                _formData['price'] = price ?? '';
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Preço de Custo'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              textInputAction: TextInputAction.next,
                              initialValue:
                                  product?.costPrice.toStringAsFixed(2),
                              validator: (costPrice) {
                                if (costPrice!.isEmpty ||
                                    double.tryParse(costPrice) == null) {
                                  return 'Informe um preço de custo válido!';
                                }

                                if (double.parse(costPrice) <= 0) {
                                  return 'Informe um valor maior que 0!';
                                }

                                return null;
                              },
                              onSaved: (costPrice) {
                                _formData['costPrice'] = costPrice ?? '';
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Consumer<CategoryProvider>(
                              builder: (context, value, child) =>
                                  DropdownButtonFormField(
                                value: product?.categoryId,
                                decoration: const InputDecoration(
                                    labelText: 'Categoria'),
                                items: value.items.map((Category category) {
                                  return DropdownMenuItem(
                                    value: category.id,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                                validator: (categoryId) {
                                  if (categoryId == null) {
                                    return 'Informe uma categoria válida!';
                                  }

                                  return null;
                                },
                                onChanged: (categoryId) {
                                  _formData['categoryId'] =
                                      categoryId.toString();
                                },
                                onSaved: (categoryId) {
                                  _formData['categoryId'] =
                                      categoryId.toString();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Consumer<SupplierProvider>(
                              builder: (context, value, child) =>
                                  DropdownButtonFormField(
                                value: product?.supplierId,
                                decoration: const InputDecoration(
                                    labelText: 'Fornecedor'),
                                items: value.items.map((supplier) {
                                  return DropdownMenuItem(
                                    value: supplier.id,
                                    child: Text(supplier.name),
                                  );
                                }).toList(),
                                validator: (supplierId) {
                                  if (supplierId == null) {
                                    return 'Informe um fornecedor válido!';
                                  }

                                  return null;
                                },
                                onChanged: (supplierId) {
                                  _formData['supplierId'] =
                                      supplierId.toString();
                                },
                                onSaved: (supplierId) {
                                  _formData['supplierId'] =
                                      supplierId.toString();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'URL da Imagem'),
                              keyboardType: TextInputType.url,
                              // initialValue: product?.urlImage,
                              textInputAction: TextInputAction.done,
                              focusNode: _imageUrlFocus,
                              controller: imageUrlController,
                              onSaved: (urlImage) {
                                _formData['urlImage'] = urlImage ?? '';
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: imageUrlController.text.isEmpty
                                ? const Center(child: Text('Informe a Url'))
                                : FittedBox(
                                    fit: BoxFit.cover,
                                    child:
                                        Image.network(imageUrlController.text),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 5,
                        ),
                        onPressed: () => _onSubmit(
                          product != null,
                          product?.id,
                        ),
                        child: Text(product == null
                            ? 'Cadastrar Produto'
                            : 'Atualizar Produto'),
                      ),
                    ],
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
