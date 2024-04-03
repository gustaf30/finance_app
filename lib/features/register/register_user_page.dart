// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/constants/app_colors.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Positioned(
              top: 300,
              left: 150,
              child: Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              ),
            ),
            Flexible(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.beige1,
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                    ),
                    margin: const EdgeInsets.only(
                        top: 200, left: 50, right: 50, bottom: 75),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 16.0, left: 16.0, right: 16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
                          child: PrimaryButton(
                            text: 'Register',
                            onPressed: () {
                              log('Register button pressed');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
