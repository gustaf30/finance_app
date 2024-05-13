// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditRendaPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const EditRendaPage({super.key, required this.firestore, required this.userEmail});

  @override
  _EditRendaPageState createState() => _EditRendaPageState();
}

class _EditRendaPageState extends State<EditRendaPage> {
  final _rendaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Renda',
          style: AppTextStyles.notSoMediumText.copyWith(color: AppColors.darkBlue2),
        ),
        centerTitle: true,
        backgroundColor: AppColors.beige1,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue2,
              AppColors.lightBlue1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColors.darkBlue2,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _rendaController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white), // Alterado para branco
                      decoration: InputDecoration(
                        labelText: 'Renda',
                        labelStyle: AppTextStyles.notSoSmallText.copyWith(color: AppColors.beige1),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.beige1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Esta alteração irá restaurar o saldo atual para o valor da renda, e o valor de despesas para 0.0.',
                      style: AppTextStyles.smallText.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Salvar',
                      onPressed: () {
                        // Salve a renda no Firestore
                        _saveRenda();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveRenda() async {
    if (_rendaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o campo de renda'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      // Atualize a renda do usuário no Firestore
      try {
        double renda = double.parse(_rendaController.text);
        await widget.firestore.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'db_renda': renda, 
          'db_despesas': 0.0,
          'db_saldo': renda,
        });
        // Retorne para a página anterior
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(firestore: widget.firestore, userEmail: widget.userEmail),
          ),
        );
      } catch (error) {
        print('Erro ao atualizar a renda do usuário: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao atualizar a renda do usuário'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _rendaController.dispose();
    super.dispose();
  }
}
