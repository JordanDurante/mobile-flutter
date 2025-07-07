import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/cliente_dao.dart';
import 'package:flutter_application_1/model/cliente.dart';
import 'package:flutter_application_1/screens/android/cliente/cliente_add.dart';
import 'package:random_color/random_color.dart';

class ClienteList  extends StatefulWidget{
  @override
  State<ClienteList> createState() => _ClienteListState();
}

class _ClienteListState extends State<ClienteList> {
  List<Cliente> _clientes = ClienteDAO.listarClientes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CLIENTES'),
      ),
      body: Column(
        children: [
          Container(
            child: TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: "Pesquisar",
                hintText: "Pesquisar cliente",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: _futureBuilderCliente(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ClienteScreen(cliente: null)
            ))
            .then((value) {
              setState(() {
                debugPrint('Adicionar novo cliente...');
              });
            });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _futureBuilderCliente() {
    return FutureBuilder<List<Cliente>>(
      initialData: const [],
      future: ClienteDAO().getClientes(),
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

            final List<Cliente> clientes = snapshot.data ?? [];

            if (clientes.isEmpty) {
              return Center(child: Text('Nenhum cliente encontrado.'));
            }

            return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final Cliente c = clientes[index];
                return ItemCliente(
                  c,
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => ClienteScreen(cliente: c)))
                        .then((value) {
                      setState(() {
                        debugPrint('Voltando do editar');
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
}

class ItemCliente extends StatelessWidget {
  final Cliente _cliente;
  final Function onClick;

  ItemCliente(this._cliente, {required this.onClick});

  Widget _avatarFotoPerfil() {
    final String foto = _cliente.foto;

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
              _cliente.nome.isNotEmpty
                  ? _cliente.nome.substring(0, 1).toUpperCase()
                  : '?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
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
          title: Text(
            _cliente.nome,
            style: TextStyle(fontSize: 15),
          ),
          subtitle: Text(
            _cliente.telefone,
            style: TextStyle(fontSize: 12),
          ),
        ),
        Divider(
          color: Colors.green,
          indent: 70.0,
          endIndent: 20,
          thickness: 2.0,
          height: 0.0,
        ),
      ],
    );
  }
}