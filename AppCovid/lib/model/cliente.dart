class Cliente {
  int _id;
  String _nome;
  String _telefone;
  int _idade;
  double _altura;
  double _peso;
  String _foto;

  Cliente(this._id, this._nome, this._telefone, this._idade, this._altura, this._peso, this._foto);

 Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nome': _nome,
      'telefone': _telefone,
      'idade': _idade,
      'altura': _altura,
      'peso': _peso,
      'foto': _foto,
    };
  }

  int get id => _id;
  String get nome => _nome;
  String get telefone => _telefone;
  int get idade => _idade;
  double get altura => _altura;
  double get peso => _peso;
  String get foto => _foto;
}
