import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuccessPasswordPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const SuccessPasswordPage(
      {super.key, required this.firestore, required this.userEmail});

  @override
  State<SuccessPasswordPage> createState() => _SuccessPasswordPageState();
}

class _SuccessPasswordPageState extends State<SuccessPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar senha',
          style: AppTextStyles.notSoMediumText
              .copyWith(color: AppColors.darkBlue2),
        ),
        centerTitle: true,
        backgroundColor: AppColors.beige1,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        firestore: widget.firestore,
                        userEmail: widget.userEmail,
                      )),
            );
          },
        ),
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
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.beige1,
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
          margin:
              const EdgeInsets.only(top: 200, left: 20, right: 20, bottom: 200),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Center(
                child: Text(
                  'Senha alterada com sucesso!',
                  style: AppTextStyles.notSoMediumText
                      .copyWith(color: AppColors.darkBlue2),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 30.0, left: 30.0, right: 30.0),
                child: PrimaryButton(
                    text: 'Voltar ao perfil',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  firestore: widget.firestore,
                                  userEmail: widget.userEmail,
                                )),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
