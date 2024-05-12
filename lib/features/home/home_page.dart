import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});
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

  List<Transaction> transactions = [
    Transaction(title: 'iFood', amount: -50.0, date: DateTime.now()),
    Transaction(title: 'Pix', amount: 21.0, date: DateTime(2024, 4, 11)),
    Transaction(title: 'Uber', amount: -12.0, date: DateTime(2024, 4, 9)),
    Transaction(title: 'Salário', amount: 1800.0, date: DateTime(2024, 4, 8)),
  ];

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
              margin: const EdgeInsets.only(top: 10, bottom: 2, right: 250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bom dia,',
                    style: AppTextStyles.smallText
                        .copyWith(color: AppColors.beige1),
                  ),
                  Text(
                    'Usuário',
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
                              '${transaction.amount > 0 ? '+' : ''} R\$ ${transaction.amount.toStringAsFixed(2)}',
                              style: AppTextStyles.notSoSmallText.copyWith(
                                  color: transaction.amount > 0
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
                builder: (context) =>
                    NewTransactionPage(firestore: widget.firestore, userEmail: widget.userEmail),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(firestore: widget.firestore, userEmail: widget.userEmail),
              ),
            );
          }
        },
      ),
    );
  }
}
