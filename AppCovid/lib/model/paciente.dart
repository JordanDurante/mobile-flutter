class Paciente {

  int _id;
  String _nome;
  String _email;
  String _cartao;
  int _idade;
  String _senha;
  
  Paciente(this._id, this._nome, this._email, this._cartao, this._idade, this._senha);

  int get id{
    return _id;
  }

  String get nome{
    return _nome;
  }

  String get email{
    return _email;
  }

  String get cartao{
    return _cartao;
  }

  int get idade{
    return _idade;
  }

  String get senha{
    return _senha;
  }




}