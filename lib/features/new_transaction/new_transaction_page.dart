import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/new_transacton_form.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:flutter/material.dart';

class NewTransactionPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const NewTransactionPage({super.key, required this.firestore, required this.userEmail});

  @override
  // ignore: library_private_types_in_public_api
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Transação',
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
        child: NewTransactionForm(firestore: widget.firestore, userEmail: widget.userEmail),
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
              MaterialPageRoute(builder: (context) => HomePage(firestore: widget.firestore, userEmail: widget.userEmail)),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(firestore: widget.firestore, userEmail: widget.userEmail)),
            );
          }
        },
      ),
    );
  }
}
