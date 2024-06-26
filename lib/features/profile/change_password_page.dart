import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/profile/success_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const ChangePasswordPage(
      {super.key, required this.firestore, required this.userEmail});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _showPassword = false;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  String _userName = '';

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
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    getUserName();
  }

  Future<void> _changePassword() async {
    if (_currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira a senha atual'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira a nova senha'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPasswordController.text == _currentPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A nova senha não pode ser igual à senha atual!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.userEmail,
          password: _currentPasswordController.text,
        );
        await userCredential.user!.updatePassword(_newPasswordController.text);
        await widget.firestore
            .collection('usuarios')
            .doc(userCredential.user!.uid)
            .update({
          'db_senha': _newPasswordController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha alterada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SuccessPasswordPage(
                  firestore: widget.firestore, userEmail: widget.userEmail)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao alterar a senha!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar Senha',
          style: AppTextStyles.notSoMediumText
              .copyWith(color: AppColors.darkBlue2),
        ),
        centerTitle: true,
        backgroundColor: AppColors.beige1,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                _userName,
                style: AppTextStyles.notSoMediumText
                    .copyWith(color: AppColors.beige1),
              ),
              Text(
                widget.userEmail,
                style: AppTextStyles.notSoSmallText
                    .copyWith(color: AppColors.beige1),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.beige1,
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 300,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _currentPasswordController,
                        obscureText: !_showPassword,
                        style: const TextStyle(color: AppColors.darkBlue2),
                        decoration: const InputDecoration(
                          labelText: 'Senha Atual',
                          labelStyle: TextStyle(color: AppColors.darkBlue2),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _newPasswordController,
                        obscureText: !_showPassword,
                        style: const TextStyle(color: AppColors.darkBlue2),
                        decoration: InputDecoration(
                          labelText: 'Nova Senha',
                          labelStyle:
                              const TextStyle(color: AppColors.darkBlue2),
                          suffixIcon: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: AppColors.darkBlue2,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue2),
                          ),
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
                            _changePassword();
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 11),
            ],
          ),
        ),
      ),
    );
  }
}
