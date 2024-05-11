import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Importe o arquivo com as opções de inicialização do Firebase

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Certifique-se de inicializar os widgets do Flutter
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use as opções de inicialização do Firebase do seu arquivo
  );
  runApp(const App());
}
