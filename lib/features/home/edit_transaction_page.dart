import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:flutter/material.dart';

class EditTransactionPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  final String userId;
  final String transactionId;
  final String category;
  final double amount;
  final bool isExpense;
  final DateTime date;

  const EditTransactionPage({
    Key? key,
    required this.firestore,
    required this.userEmail,
    required this.userId,
    required this.transactionId,
    required this.category,
    required this.amount,
    required this.isExpense,
    required this.date,
  }) : super(key: key);

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  late TextEditingController _categoryController;
  late TextEditingController _amountController;
  late bool _isExpense;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.category);
    _amountController = TextEditingController(text: widget.amount.toString());
    _isExpense = widget.isExpense;
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Transação',
          style: AppTextStyles.notSoMediumText
              .copyWith(color: AppColors.darkBlue2),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _categoryController,
                      style: TextStyle(
                          color: Colors
                              .white), // Texto branco para melhor visibilidade
                      decoration: InputDecoration(
                        labelText: 'Categoria',
                        labelStyle: AppTextStyles.notSoSmallText
                            .copyWith(color: AppColors.beige1),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.beige1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors
                              .white), // Texto branco para melhor visibilidade
                      decoration: InputDecoration(
                        labelText: 'Valor',
                        labelStyle: AppTextStyles.notSoSmallText
                            .copyWith(color: AppColors.beige1),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.beige1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _isExpense,
                          onChanged: (value) {
                            setState(() {
                              _isExpense = value!;
                            });
                          },
                        ),
                        Text(
                          'Despesa',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: AppColors.beige1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(
                        'Data: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Salvar',
                      onPressed: () {
                        // Salvar a transação editada
                        _updateTransaction();
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog();
                      },
                      child: Text('Excluir Transação'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir esta transação?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteTransaction();
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _deleteTransaction() async {
    try {
      // Remover a transação do Firestore
      await widget.firestore
          .collection('usuarios')
          .doc(widget.userId)
          .collection('transacoes')
          .doc(widget.transactionId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transação excluída com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Atualizar o saldo e as despesas se necessário
      if (_isExpense) {
        final DocumentSnapshot userDoc = await widget.firestore
            .collection('usuarios')
            .doc(widget.userId)
            .get();
        if (userDoc.exists) {
          final Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          final double currentExpenses = userData['db_despesas'];
          final double currentBalance = userData['db_saldo'];
          final double newExpenses = currentExpenses - widget.amount;
          final double newBalance = currentBalance + widget.amount;
          await widget.firestore
              .collection('usuarios')
              .doc(widget.userId)
              .update({'db_despesas': newExpenses, 'db_saldo': newBalance});
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            firestore: widget.firestore,
            userEmail: widget.userEmail,
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao excluir a transação'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateTransaction() async {
    final String newCategory = _categoryController.text;
    final double newAmount = double.parse(_amountController.text);
    final double oldAmount = widget.amount;
    final bool isExpense = _isExpense;

    try {
      await widget.firestore
          .collection('usuarios')
          .doc(widget.userId)
          .collection('transacoes')
          .doc(widget.transactionId)
          .update({
        'categoria': newCategory,
        'valor': newAmount,
        'despesa': _isExpense,
        'data': _selectedDate, // Atualiza a data da transação
      });

      final double difference = oldAmount - newAmount;

      if (isExpense) {
        // Se for uma despesa, subtrai a diferença do saldo e das despesas
        final DocumentSnapshot userDoc = await widget.firestore
            .collection('usuarios')
            .doc(widget.userId)
            .get();
        if (userDoc.exists) {
          final Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          final double currentExpenses = userData['db_despesas'];
          final double currentBalance = userData['db_saldo'];
          final double newExpenses = currentExpenses - difference;
          final double newBalance = currentBalance - difference;
          await widget.firestore
              .collection('usuarios')
              .doc(widget.userId)
              .update({'db_despesas': newExpenses, 'db_saldo': newBalance});
        }
      } else {
        // Se for uma receita, adiciona a diferença ao saldo
        final DocumentSnapshot userDoc = await widget.firestore
            .collection('usuarios')
            .doc(widget.userId)
            .get();
        if (userDoc.exists) {
          final Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          final double currentBalance = userData['db_saldo'];
          final double newBalance = currentBalance + difference;
          await widget.firestore
              .collection('usuarios')
              .doc(widget.userId)
              .update({'db_saldo': newBalance});
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transação atualizada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            firestore: widget.firestore,
            userEmail: widget.userEmail,
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao atualizar a transação'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
