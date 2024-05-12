// ignore_for_file: library_private_types_in_public_api

import 'package:finance_app/features/profile/profile_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_colors.dart';
import 'primary_button.dart';

class SignUpFormBox extends StatefulWidget {
  final FirebaseFirestore firestore;
  const SignUpFormBox({super.key, required this.firestore});

  @override
  _SignUpFormBoxState createState() => _SignUpFormBoxState();
}

class _SignUpFormBoxState extends State<SignUpFormBox> {
  late String _nome = '';
  late String _email = '';
  late String _senha = '';
  late String _senha2 = '';

 void _signUp() async {
  bool isEmailValid = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z.]+$').hasMatch(_email);

  if (_nome.isEmpty || _email.isEmpty || _senha.isEmpty || _senha2.isEmpty) {
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
    try {
      // Cria o usuário no Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _senha,
      );

      // Após criar o usuário com sucesso, armazena informações adicionais no Firestore
      await widget.firestore.collection('usuarios').doc(userCredential.user!.uid).set({
        'db_nome': _nome,
        'db_senha': _senha,
        'db_email': _email,
      });

      // Cria uma subcoleção de transações para o novo usuário
      await widget.firestore.collection('usuarios').doc(userCredential.user!.uid).collection('transacoes').doc().set({
        'categoria': ' ',
        'data': DateTime.now(),
        'despeza': true,
        'valor': 0.0,
      });

      // Navega para a tela de perfil após criar o usuário com sucesso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(firestore: widget.firestore, userEmail: _email)),
      );
    } catch (e) {
      print('Erro ao salvar usuário: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao salvar usuário. Tente novamente mais tarde.'),
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
        margin: const EdgeInsets.only(top: 30, bottom: 100, left: 50, right: 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin:
                  const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
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
                            builder: (context) => SignInPage(firestore: widget.firestore,)),
                      );
                    },
                    child: const Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 10, 12),
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
