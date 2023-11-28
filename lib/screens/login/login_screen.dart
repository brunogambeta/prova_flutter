// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/dialogs_utils.dart';
import '../../utils/privacy_policy.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(27, 76, 96, 1),
              Color.fromRGBO(42, 141, 136, 1.0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Usuário',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextField(
                          controller: loginController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Senha',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          validateAndNavigate(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                showPrivacyPolicy(context);
              },
              child: const Text(
                'Política de privacidade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateAndNavigate(BuildContext context) async {
    String login = loginController.text.trim();
    String password = passwordController.text.trim();

    if (login.isEmpty) {
      showAlert(context, 'Informe o login.');
    } else if (password.isEmpty) {
      showAlert(context, 'Informe a senha.');
    } else if (password.length < 2) {
      showAlert(context, 'A senha deve ter pelo menos 2 caracteres.');
    } else if (password.contains(RegExp(r'[^\w\s]'))) {
      showAlert(context, 'A senha não pode conter caracteres especiais.');
    } else if (login.length > 20 || password.length > 20) {
      showAlert(context, 'Login e senha não podem ter mais de 20 caracteres.');
    } else if (login.endsWith(' ') || password.endsWith(' ')) {
      showAlert(context, 'Login e senha não podem terminar com espaços.');
    } else {
      bool isCredentialsValid =
          await mockApiValidateCredentials(login, password);

      if (isCredentialsValid) {
        Navigator.pushNamed(context, '/captured');
      } else {
        showAlert(context, 'Credenciais inválidas. Tente novamente.');
      }
    }
  }

  Future<bool> mockApiValidateCredentials(String login, String password) async {
    final response = await http.get(
      Uri.parse('https://6556b403bd4bcef8b611906d.mockapi.io/api/login/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        if (user['username'] == login && user['password'] == password) {
          return true;
        }
      }
    }
    return false;
  }
}
