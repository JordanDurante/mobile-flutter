
import 'package:flutter_application_1/model/paciente.dart';

class PacienteDAO {
  static final List<Paciente> _pacientes = [];

  static adicionar (Paciente p){
    _pacientes.add(p);
  }


  static get listarPacientes{
    return _pacientes;
  }
}