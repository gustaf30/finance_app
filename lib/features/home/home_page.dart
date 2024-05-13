// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/home/edit_income_page.dart';
import 'package:finance_app/features/home/edit_transaction_page.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isExpense;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.isExpense});
}

class HomePage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const HomePage({super.key, required this.firestore, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  double _userBalance = 0.0;
  double _userExpense = 0.0;
  double _userIncome = 0.0;
  String _userName = '';
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    getUserData();
    getTransactions();
  }

  Future<void> _refreshData() async {
    try {
      await getUserData();
      getTransactions();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados atualizados com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar os dados: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void getTransactions() async {
    try {
      QuerySnapshot querySnapshot = await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('transacoes')
          .orderBy('data', descending: true)
          .get();

      List<Transaction> fetchedTransactions = [];
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        fetchedTransactions.add(Transaction(
          id: document.id,
          title: data['categoria'],
          amount: data['valor'].toDouble(),
          date: (data['data'] as Timestamp).toDate(),
          isExpense: data['despesa'] as bool,
        ));
      }

      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      print('Erro ao buscar transações: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userDoc = await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userName = userData['db_nome'];
          _userIncome = userData['db_renda'].toDouble();
          _userExpense = userData['db_despesas'].toDouble();
          _userBalance = userData['db_saldo'].toDouble();
        });
      } else {
        print('Documento do usuário não encontrado');
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
    }
  }

  void _updateDespesas(double newValue) async {
    try {
      await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'db_despesas': newValue, 'db_saldo': _userIncome - newValue});
      setState(() {
        _userExpense = newValue;
        _userIncome = _userIncome - newValue;
      });
    } catch (error) {
      print('Erro ao atualizar despesas no banco de dados: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao atualizar despesas no banco de dados'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _editTransaction(Transaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTransactionPage(
          userEmail: widget.userEmail,
          userId: FirebaseAuth.instance.currentUser!.uid,
          transactionId: transaction.id,
          firestore: widget.firestore,
          category: transaction.title,
          amount: transaction.amount,
          isExpense: transaction.isExpense,
          date: transaction.date,
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightBlue1,
                  AppColors.lightBlue2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 2, right: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá,',
                        style: AppTextStyles.smallText
                            .copyWith(color: AppColors.beige1),
                      ),
                      Text(
                        _userName,
                        style: AppTextStyles.notSoSmallText
                            .copyWith(color: AppColors.beige1),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.darkBlue2,
                        AppColors.lightBlue1,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 110),
                        child: Column(
                          children: [
                            Text(
                              'Saldo',
                              style: AppTextStyles.notSoMediumText
                                  .copyWith(color: AppColors.beige1),
                            ),
                            Text(
                              'R\$ $_userBalance',
                              style: AppTextStyles.notSoMediumText
                                  .copyWith(color: AppColors.beige1),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40, left: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ' Renda',
                                      style: AppTextStyles.notSoSmallText
                                          .copyWith(color: AppColors.beige1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditRendaPage(
                                              firestore: widget.firestore,
                                              userEmail: widget.userEmail,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.edit,
                                          color: AppColors.beige1),
                                    ),
                                  ],
                                ),
                                Text(
                                  _userIncome.toString(),
                                  style: AppTextStyles.notSoSmallText
                                      .copyWith(color: AppColors.beige1),
                                ),
                              ],
                            ),
                            const SizedBox(width: 60),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_down,
                                      color: AppColors.beige1,
                                      size: 20.0,
                                    ),
                                    Text(
                                      ' Despesas',
                                      style: AppTextStyles.notSoSmallText
                                          .copyWith(color: AppColors.beige1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _updateDespesas(0.0);
                                      },
                                      child: const Icon(
                                        Icons.refresh,
                                        color: AppColors.beige1,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _userExpense.toString(),
                                  style: AppTextStyles.notSoSmallText
                                      .copyWith(color: AppColors.beige1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.beige1,
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 350,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Histórico de transações',
                            style: AppTextStyles.notSoSmallText
                                .copyWith(color: AppColors.darkBlue1),
                          ),
                        ),
                        Column(
                          children: transactions.where((transaction) => transaction.amount.abs() != 0).map((transaction) {
                            return GestureDetector(
                              onTap: () {
                                _editTransaction(transaction);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        transaction.title,
                                        style: AppTextStyles.notSoSmallText
                                            .copyWith(
                                                color: AppColors.darkBlue1),
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(transaction.date),
                                        style: AppTextStyles.smallText
                                            .copyWith(
                                                color: AppColors.darkBlue1),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    transaction.amount.abs().toStringAsFixed(2),
                                    style: AppTextStyles.notSoSmallText.copyWith(
                                        color: transaction.isExpense == false
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
               const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: AppColors.beige1,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Novo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.lightBlue1,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTransactionPage(
                firestore: widget.firestore,
                userEmail: widget.userEmail,
              ),
            ),
          );
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                firestore: widget.firestore,
                userEmail: widget.userEmail,
              ),
            ),
          );
        }
      },
    ),
  );
}

}
