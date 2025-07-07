import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/paciente_dao.dart';
import 'package:flutter_application_1/model/paciente.dart';
import 'package:flutter_application_1/screens/android/appcovid.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  
  _geraPacientes(){
    Paciente p = Paciente(12, 'Jordan Durante', 'jordan_durante@hotmail.com', 'txt123', 30, 'testesenha','');
    
    //PacienteDAO.adicionar(p);
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




