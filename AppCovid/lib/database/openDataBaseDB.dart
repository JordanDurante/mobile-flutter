import 'package:flutter_application_1/database/cliente_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'dbacademia.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(ClienteDAO.sqlTabelaCliente);
    },
    version: 1,
  );
}
