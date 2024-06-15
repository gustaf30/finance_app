// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/new_transaction/new_transaction_page.dart';
import 'package:finance_app/features/profile/change_name_page.dart';
import 'package:finance_app/features/profile/change_password_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final String userEmail;
  const ProfilePage(
      {super.key, required this.firestore, required this.userEmail});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  String _userName = '';
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    getUserName();
    getUserProfileImage();
  }

  Future<void> getUserProfileImage() async {
    try {
      DocumentSnapshot userDoc = await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _profileImageUrl = userData['profile_image_url'] ?? '';
        });
      }
    } catch (e) {
      print('Erro ao buscar imagem do usuário: $e');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Escolher entre câmera e galeria
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Selecionar imagem de"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('Câmera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('Galeria'),
          ),
        ],
      ),
    );
    if (source != null) {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        await _uploadImageToFirebase(image);
      }
    }
  }

  Future<void> _uploadImageToFirebase(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

      await storageRef.putFile(File(image.path));
      String downloadUrl = await storageRef.getDownloadURL();

      await widget.firestore
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profile_image_url': downloadUrl});

      setState(() {
        _profileImageUrl = downloadUrl;
      });
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
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
      appBar: AppBar(
        title: Text(
          'Perfil',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                heightFactor: 1.5,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: ClipOval(
                    child: _profileImageUrl.isEmpty
                        ? Image.asset(
                            'assets/images/profile_picture.jpg',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            _profileImageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
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
              const SizedBox(height: 30),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.beige1,
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20), // Ajuste as margens aqui
                height: 200, // Ajuste a altura conforme necessário
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNamePage(
                                  firestore: widget.firestore,
                                  userEmail: widget.userEmail)),
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
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordPage(
                                  firestore: widget.firestore,
                                  userEmail: widget.userEmail)),
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
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignInPage(firestore: widget.firestore)),
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
              const SizedBox(
                  height:
                      33), // Adiciona margem abaixo do contêiner com as opções
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
              MaterialPageRoute(
                  builder: (context) => HomePage(
                      firestore: widget.firestore,
                      userEmail: widget.userEmail)),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewTransactionPage(
                      firestore: widget.firestore,
                      userEmail: widget.userEmail)),
            );
          }
        },
      ),
    );
  }
}
