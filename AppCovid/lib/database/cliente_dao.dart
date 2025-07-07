import 'package:flutter_application_1/database/openDataBaseDB.dart';
import 'package:flutter_application_1/model/cliente.dart';
import 'package:sqflite/sqflite.dart';

class ClienteDAO {
  static final List<Cliente> _clientes = [];

  static const String _nomeTabela = 'cliente';
  static const String _col_id = 'id';
  static const String _col_nome = 'nome';
  static const String _col_telefone = 'telefone';
  static const String _col_idade = 'idade';
  static const String _col_altura = 'altura';
  static const String _col_peso = 'peso';
  static const String _col_foto = 'foto';

  static const String sqlTabelaCliente = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_col_nome TEXT, '
      '$_col_telefone TEXT, '
      '$_col_idade INTEGER, '
      '$_col_altura REAL, '
      '$_col_peso REAL, '
      '$_col_foto TEXT)';

  static adicionar(Cliente c) async {
    _clientes.add(c);

    final Database db = await getDatabase();
    await db.insert(_nomeTabela, c.toMap());
  }

  static Cliente getCliente(int index) {
    return _clientes.elementAt(index);
  }

  atualizar(Cliente c) async {
    final Database db = await getDatabase();
    db.update(_nomeTabela, c.toMap(), where: 'id=?', whereArgs: [c.id]);
  }

  static get listarClientes {
    return _clientes;
  }

  Future<List<Cliente>> getClientes() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    return List.generate(maps.length, (i) {
      return Cliente(
        maps[i][_col_id],
        maps[i][_col_nome],
        maps[i][_col_telefone],
        maps[i][_col_idade],
        maps[i][_col_altura],
        maps[i][_col_peso],
        maps[i][_col_foto],
      );
    });
  }
}
