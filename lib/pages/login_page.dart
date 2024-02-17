import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdv_app/provider/user_provider.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:provider/provider.dart';

import '../utils/colors_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _passwordFocus = FocusNode();

  final _formData = <String, String>{};
  bool _loading = false;

  void _onSubmit() async {
    setState(() {
      _loading = true;
    });

    try {
      final isValid = _formKey.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      _formKey.currentState?.save();

      final isAutenticated =
          await Provider.of<UserProvider>(context, listen: false)
              .login(_formData);

      if (isAutenticated) {
        Navigator.of(context).pushReplacementNamed(AppRouter.shift);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário ou senha inválidos'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primary800,
      body: Stack(
        children: <Widget>[
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(
                color: ColorsTheme.primary500,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Bem vindo de volta!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text("Faça login para continuar",
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                      const SizedBox(height: 12),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              onSaved: (name) => _formData['name'] = name ?? '',
                              validator: (name) {
                                if (name?.isEmpty ?? true) {
                                  return 'Nome é obrigatório';
                                }

                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              obscureText: true,
                              focusNode: _passwordFocus,
                              onSaved: (password) =>
                                  _formData['password'] = password ?? '',
                              validator: (password) {
                                if (password?.isEmpty ?? true) {
                                  return 'Senha é obrigatória';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsTheme.secondary500,
                                ),
                                onPressed: () {
                                  _onSubmit();
                                },
                                child: _loading
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
