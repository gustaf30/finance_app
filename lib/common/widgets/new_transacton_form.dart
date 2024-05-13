import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'primary_button.dart';

class NewTransactionForm extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const NewTransactionForm(
      {super.key, required this.firestore, required this.userEmail});

  @override
  State<NewTransactionForm> createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  String? _transactionType;
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();

  void _add() {
    if (_valueController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_transactionType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione o tipo de transação'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transação adicionada!'),
          backgroundColor: AppColors.lightBlue1,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                firestore: widget.firestore, userEmail: widget.userEmail)),
      );
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.beige1,
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Valor',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      hintText: 'Categoria',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null) {
                        setState(() {
                          _dateController.text = picked.toString();
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          hintText: 'Data',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 'Despesa',
                        groupValue: _transactionType,
                        onChanged: (value) {
                          setState(() {
                            _transactionType = value.toString();
                          });
                          log('Despesa selecionada');
                        },
                      ),
                      const Text('Despesa'),
                      Radio(
                        value: 'Receita',
                        groupValue: _transactionType,
                        onChanged: (value) {
                          setState(() {
                            _transactionType = value.toString();
                          });
                          log('Receita selecionada');
                        },
                      ),
                      const Text('Receita'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: PrimaryButton(
                    text: 'Adicionar',
                    onPressed: _add,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
