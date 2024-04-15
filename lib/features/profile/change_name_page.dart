import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:finance_app/features/profile/success_name_page.dart';
import 'package:flutter/material.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({super.key});

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar nome',
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
            const SizedBox(height: 50),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 300, // Ajuste a altura conforme necessário
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: AppTextStyles.notSoSmallText.copyWith(color: AppColors.darkBlue2),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkBlue2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: PrimaryButton(
                      text: 'Salvar', 
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SuccessNamePage()),
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}