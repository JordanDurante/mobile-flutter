import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cliente.dart';
import 'package:flutter_application_1/screens/android/appgym.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Função para gerar alguns clientes iniciais para testar
  _geraClientes() {
    Cliente c1 = Cliente(12, 'Jordan Durante', '123456789', 30, 1.75, 75.0, '');

    //ClienteDAO.adicionar(c1);
  }

  if (Platform.isAndroid) {
    debugPrint('App rodando no Android');
    _geraClientes();
    runApp(Appgym());
  }

  if (Platform.isIOS) {
    debugPrint('App rodando no iOS');
  }
}
