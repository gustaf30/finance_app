import 'package:finance_app/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/sign_in/password_recover_page.dart';
import 'package:finance_app/features/sign_up/sign_up_page.dart';
import 'primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInFormBox extends StatefulWidget {
  final FirebaseFirestore firestore;
  const SignInFormBox({super.key, required this.firestore});

  @override
  // ignore: library_private_types_in_public_api
  _SignInFormBoxState createState() => _SignInFormBoxState();
}

class _SignInFormBoxState extends State<SignInFormBox> {
  final _auth = FirebaseAuth.instance;
  bool _showPassword = false;
  late String _email = '';
  late String _senha = '';

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void getUserData(String email) async {
    try {
      DocumentSnapshot userDoc =
          await widget.firestore.collection('usuarios').doc(email).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('Dados do usuário: $userData');
      } else {
        print('Documento do usuário não encontrado');
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
    }
  }

  void _signIn(String email, String senha, BuildContext context) async {
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
      print('Email: $email');
      print('Senha: $senha');
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: senha,
        );
        App.userCredential = userCredential;
        getUserData(email);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(firestore: widget.firestore, userEmail: email)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao fazer login: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
        margin:
            const EdgeInsets.only(top: 80, bottom: 100, left: 50, right: 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 0),
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
                      onPressed: () {
                        _signIn(_email, _senha, context);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpPage(firestore: widget.firestore)),
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
                            builder: (context) => PasswordRecoverPage(
                                firestore: widget.firestore)),
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
