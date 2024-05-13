import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/app.dart';
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
  bool despesa = false;
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();

  Future<void> _add() async {
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
      try {
        final DateTime date = DateTime.parse(_dateController.text);
        final Timestamp timestamp = Timestamp.fromDate(date);
        if (_transactionType == 'despesa') {
          despesa = true;
        }
        await widget.firestore
            .collection('usuarios')
            .doc(App.userCredential?.user!.uid)
            .collection('transacoes')
            .add({
          'categoria': _categoryController.text,
          'data': timestamp,
          'valor': double.parse(_valueController.text),
          'despesa': despesa,
        });
        if(despesa == true) {
          await widget.firestore
              .collection('usuarios')
              .doc(App.userCredential?.user!.uid)
              .update({
            'db_despesas': FieldValue.increment(double.parse(_valueController.text)), 'db_saldo': FieldValue.increment(-double.parse(_valueController.text)),
          });
        } else {
          await widget.firestore
              .collection('usuarios')
              .doc(App.userCredential?.user!.uid)
              .update({
            'db_saldo': FieldValue.increment(double.parse(_valueController.text)),
          });
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  firestore: widget.firestore, userEmail: widget.userEmail)
                ),
        );
      } catch (e) {
        log('Erro ao adicionar transação: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao adicionar transação'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transação adicionada!'),
          backgroundColor: AppColors.lightBlue1,
        ),
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
                        value: 'despesa',
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
                        value: 'receita',
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
