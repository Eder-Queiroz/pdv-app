import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

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

  _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Codigo de Barras'),
                              textInputAction: TextInputAction.next,
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
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'URL da Imagem'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              focusNode: _imageUrlFocus,
                              controller: _imageUrlController,
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
                            child: _imageUrlController.text.isEmpty
                                ? const Center(child: Text('Informe a Url'))
                                : FittedBox(
                                    fit: BoxFit.cover,
                                    child:
                                        Image.network(_imageUrlController.text),
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
                        onPressed: _onSubmit,
                        child: const Text('Salvar'),
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
