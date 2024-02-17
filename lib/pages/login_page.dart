import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primary800,
      body: Stack(
        children: <Widget>[
          Transform.flip(
            flipX: true,
            flipY: true,
            child: Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
                width: MediaQuery.of(context).size.width,
              ),
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
              height: MediaQuery.of(context).size.height * 0.36,
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
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorsTheme.secondary500,
                                ),
                                onPressed: () {},
                                child: const Text(
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
