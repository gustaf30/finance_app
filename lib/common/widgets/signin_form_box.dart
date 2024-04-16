import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/sign_in/password_recover_page.dart';
import 'package:finance_app/features/sign_up/sign_up_page.dart';
import 'primary_button.dart';

class SignInFormBox extends StatefulWidget {
  const SignInFormBox({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInFormBoxState createState() => _SignInFormBoxState();
}

class _SignInFormBoxState extends State<SignInFormBox> {
  bool _showPassword = false;
  late String _email = '';
  late String _senha = '';

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _signIn() {
    bool isEmailValid = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z.]+$').hasMatch(_email);

    if (!isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um email válido!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } 
    if (_senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira uma senha!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
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
        margin: const EdgeInsets.only(top: 80, bottom: 100, left: 50, right: 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
              child: Column(
                children: [
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
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(_showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: AppColors.darkBlue2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 15.0, left: 16.0, right: 16.0),
                    child: PrimaryButton(
                      text: 'Entrar',
                      onPressed: _signIn,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Não tenho uma conta',
                      style: TextStyle(
                        color: AppColors.lightBlue2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordRecoverPage()),
                      );
                    },
                    child: const Text(
                      'Esqueci minha senha',
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
