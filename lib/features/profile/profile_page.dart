import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/change_name_page.dart';
import 'package:finance_app/features/profile/change_password_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseFirestore firestore;
  const ProfilePage({super.key, required this.firestore});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                heightFactor: 1.5,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile_picture.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Usuário da Silva',
                style: AppTextStyles.notSoMediumText.copyWith(color: AppColors.beige1),
              ),
              Text(
                'usuario@email.com.br',
                style: AppTextStyles.notSoSmallText.copyWith(color: AppColors.beige1),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.beige1,
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Ajuste as margens aqui
                height: 200, // Ajuste a altura conforme necessário
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangeNamePage(firestore: widget.firestore)),
                        );
                      },
                      child: const Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(Icons.person_rounded),
                          SizedBox(width: 10),
                          Text(
                            'Mudar nome',
                            style: AppTextStyles.notSoSmallText,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePasswordPage(firestore: widget.firestore)),
                        );
                      },
                      child: const Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(Icons.password),
                          SizedBox(width: 10),
                          Text(
                            'Alterar senha',
                            style: AppTextStyles.notSoSmallText,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage(firestore: widget.firestore)),
                        );
                      },
                      child: const Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text(
                            'Sair',
                            style: AppTextStyles.notSoSmallText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 33), // Adiciona margem abaixo do contêiner com as opções
            ],
          ),
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
        selectedItemColor: AppColors.lightBlue1,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  HomePage(firestore: widget.firestore)),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewTransactionPage(firestore: widget.firestore)),
            );
          }
        },
      ),
    );
  }
}
