import 'package:finance_app/features/profile/profile_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'primary_button.dart';

class SignUpFormBox extends StatefulWidget {
  const SignUpFormBox({super.key});

  @override
  _SignUpFormBoxState createState() => _SignUpFormBoxState();
}

class _SignUpFormBoxState extends State<SignUpFormBox> {
  late String _nome = '';
  late String _email = '';
  late String _senha = '';
  late String _senha2 = '';

  void _signUp() {
    bool isEmailValid = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z.]+$').hasMatch(_email);

    if (_nome == '' || _email == '' || _senha == '' || _senha2 == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (_senha != _senha2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem!'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um email válido!'),
          backgroundColor: Colors.red,
        ),
      );
      } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.beige1,
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        margin: const EdgeInsets.only(top: 30, bottom: 50, left: 50, right: 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin:
                  const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: TextField(
                      onChanged: (value) {
                        _nome = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Nome completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        _senha = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        _senha2 = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Confirme a senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
                    child: PrimaryButton(
                      text: 'Cadastrar',
                      onPressed: () {
                        _signUp();
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    child: const Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        color: AppColors.lightBlue2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
