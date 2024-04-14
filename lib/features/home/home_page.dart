import 'dart:convert';

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
                          'R\$ 1.000,00',
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
                              'R\$ 1.800,00',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.beige1),
                            ),
                          ],
                        ),
                        const SizedBox(width: 100),
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
                              'R\$ 800,00',
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
              height: 400, // Ajuste a altura conforme necessário
              width: double.infinity, // Ocupar toda a largura disponível
              child: Center(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Histórico de transações',
                        style: AppTextStyles.notSoSmallText
                            .copyWith(color: AppColors.darkBlue1),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'iFood',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              'Hoje',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '- R\$ 50,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Pix',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '11/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '+ R\$ 21,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Uber',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '09/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '- R\$ 12,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Pix',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '09/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '+ R\$ 10,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Pix',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '08/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '+ R\$ 4,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Restaurante',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '06/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '- R\$ 22,90',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Aluguel',
                              style: AppTextStyles.notSoSmallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                            Text(
                              '05/04/2024',
                              style: AppTextStyles.smallText
                                  .copyWith(color: AppColors.darkBlue1),
                            ),
                          ],
                        ),
                        Text(
                          '- R\$ 720,00',
                          style: AppTextStyles.notSoSmallText
                              .copyWith(color: Colors.red),
                        ),
                      ],
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
                builder: (context) => const NewTransactionPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
