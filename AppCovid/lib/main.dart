import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/paciente_dao.dart';
import 'package:flutter_application_1/model/paciente.dart';
import 'package:flutter_application_1/screens/android/appcovid.dart';

void main() {

  _geraPacientes(){
    Paciente p = Paciente(12, 'Jordan Durante', 'jordan_durante@hotmail.com', 'txt123', 30, 'testesenha');
    Paciente p1 = Paciente(2, 'José Teste', 'testemail@hotmail.com', 'txt123', 30, 'testesenha');
    Paciente p2 = Paciente(1, 'Paulo Augusto', 'augusto_mail@hotmail.com', 'txt123', 30, 'testesenha');

    PacienteDAO.adicionar(p);
    PacienteDAO.adicionar(p1);
    PacienteDAO.adicionar(p2);
  }

  if(Platform.isAndroid) {
    debugPrint('app no android');
    _geraPacientes();
    runApp(Appcovid());
  }
  if(Platform.isIOS) {
    debugPrint('app no IOS');
  }

}




