import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/paciente_dao.dart';
import 'package:flutter_application_1/model/paciente.dart';
import 'package:flutter_application_1/screens/android/paciente/paciente_add.dart';
import 'package:random_color/random_color.dart';

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
              child: _futureBuilderPaciente(),
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PacienteScreen(paciente: null)
            ))
            .then((value) {
              setState(() {
                debugPrint('adicionar .....');
              });
            }); 
          },
          child: Icon(Icons.add),
        ),
    );
  }


  Widget _futureBuilderPaciente() {
    return FutureBuilder<List<Paciente>>(
      initialData: const [],
      future: PacienteDAO().getPacientes(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando...'),
                ],
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final List<Paciente> pacientes = snapshot.data ?? [];

            if (pacientes.isEmpty) {
              return Center(child: Text('Nenhum paciente encontrado.'));
            }

            return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final Paciente p = pacientes[index];
                return ItemPaciente(
                  p,
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => PacienteScreen(paciente: p)))
                        .then((value) {
                      setState(() {
                        debugPrint('..voltou do editar');
                      });
                    });
                  },
                );
              },
            );
        }
      },
    );
  }


  Widget _oldListPacientes(){

    List<Paciente> _pacientes = PacienteDAO.listarPacientes;
    return ListView.builder(
                  itemCount: _pacientes.length,
                  itemBuilder: (context, index){
                    final Paciente p = _pacientes[index];
                    return ItemPaciente(p, onClick: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PacienteScreen(paciente: p))
                        ).then((value){
                          setState(() {
                            debugPrint('voltou do editar');
                          });
                        });
                    },);
                  }
                );
  }
}


class ItemPaciente extends StatelessWidget {

  final Paciente _paciente;
  final Function onClick;

  ItemPaciente(this._paciente, {required this.onClick});

  Widget _avatarAntigo(){
    return CircleAvatar(
            backgroundImage: AssetImage('imagens/avatar.png'),
          );
  }

  Widget _avatarFotoPerfil() {
    final String foto = _paciente.foto;

    final bool temFotoValida = foto.isNotEmpty && File(foto).existsSync();

    final RandomColor corRandom = RandomColor();
    final Color cor = corRandom.randomColor(
      colorBrightness: ColorBrightness.light,
    );

    return CircleAvatar(
      backgroundColor: cor,
      foregroundColor: Colors.white,
      radius: 22.0,
      backgroundImage: temFotoValida
          ? FileImage(File(foto))
          : null,
      child: temFotoValida
          ? null
          : Text(
              _paciente.nome.isNotEmpty
                  ? _paciente.nome.substring(0, 1).toUpperCase()
                  : '?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white ,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onClick(),
          leading: _avatarFotoPerfil(), 
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

enum ItensMenuListPaciente {resultados, novoCecklist}