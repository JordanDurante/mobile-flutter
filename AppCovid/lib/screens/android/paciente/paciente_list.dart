import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/paciente_dao.dart';
import 'package:flutter_application_1/model/paciente.dart';

class PacienteList  extends StatefulWidget{
  @override
  State<PacienteList> createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  List<Paciente> _pacientes = PacienteDAO.listarPacientes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PACIENTES'),
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.red,
            child: TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: "Pesquis1ar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: ListView.builder(
                itemCount: _pacientes.length,
                itemBuilder: (context, index){
                  final Paciente p = _pacientes[index];
                  return ItemPaciente(p);
                }
              ),
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Paciente p = Paciente(4, 'Andressa', 'andressa@hotmail.com', 'txt123', 30, 'testesenha');
          PacienteDAO.adicionar(p);
          setState(() {
            debugPrint('adicionar .....');
            
          });
        },
        child: Icon(Icons.add),
        ),
    );
  }
}

class ItemPaciente extends StatelessWidget {

  final Paciente _paciente;
  ItemPaciente(this._paciente);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('imagens/avatar.png'),
          ),
          title: Text(_paciente.nome, 
            style: TextStyle(fontSize: 15),
            ),
            subtitle: Text(_paciente.email,
              style: TextStyle(fontSize: 12),
            ),
            trailing: _menu(),
        ),
        Divider(
          color: Colors.green,
          indent: 70.0,
          endIndent: 20,
          thickness: 2.0,
          height: 0.0,
        ),
      ]
    );
  }

  Widget _menu(){
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado){
        debugPrint('selecionado... $selecionado');
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
        const PopupMenuItem(
          value: ItensMenuListPaciente.editar,
          child: Text('Editar'),
        ),
        const PopupMenuItem(
          value: ItensMenuListPaciente.resultados,
          child: Text('Resultados'),
        ),
        const PopupMenuItem(
          value: ItensMenuListPaciente.novoCecklist,
          child: Text('Novo Checklist'),
        )
      ],

    );
  }

}

enum ItensMenuListPaciente {editar, resultados, novoCecklist}