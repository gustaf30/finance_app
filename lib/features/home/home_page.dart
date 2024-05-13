// ignore_for_file: avoid_print

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;
  final bool isExpense;

  Transaction({required this.title, required this.amount, required this.date, required this.isExpense});
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
  double saldo = 1000.0;
  double renda = 1800.0;
  double despesas = 800.0;
  String _userName = '';
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    getUserName();
    getTransactions();
  }

  void getTransactions() async {
  try {
    // Consulta as transações do usuário atual ordenadas por data
    QuerySnapshot querySnapshot = await widget.firestore
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transacoes')
        .orderBy('data', descending: true) // ordenar por data em ordem decrescente
        .get();

    List<Transaction> fetchedTransactions = [];
    for (var document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      fetchedTransactions.add(Transaction(
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


  void getUserName() async {
    try {
      DocumentSnapshot userDoc = await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('Dados do usuário: $userData');
        setState(() {
          _userName = userData['db_nome'];
        });
      } else {
        print('Documento do usuário não encontrado');
      }
    } catch (e) {
      print('Erro ao buscar nome do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                          'R\$ $saldo',
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
                                const Icon(
                                  Icons.arrow_circle_up,
                                  color: AppColors.beige1,
                                  size: 20.0,
                                ),
                                Text(
                                  ' Renda',
                                  style: AppTextStyles.notSoSmallText
                                      .copyWith(color: AppColors.beige1),
                                ),
                              ],
                            ),
                            Text(
                              'R\$ $renda',
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
                              ],
                            ),
                            Text(
                              'R\$ $despesas',
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
              height: 350, // Ajuste a altura conforme necessário
              width: double.infinity, // Ocupar toda a largura disponível
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
                      children: transactions.map((transaction) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  transaction.title,
                                  style: AppTextStyles.notSoSmallText
                                      .copyWith(color: AppColors.darkBlue1),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(transaction.date),
                                  style: AppTextStyles.smallText
                                      .copyWith(color: AppColors.darkBlue1),
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
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
                    firestore: widget.firestore, userEmail: widget.userEmail),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                    firestore: widget.firestore, userEmail: widget.userEmail),
              ),
            );
          }
        },
      ),
    );
  }
}
