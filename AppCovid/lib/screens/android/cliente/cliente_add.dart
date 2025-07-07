import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/cliente_dao.dart';
import 'package:flutter_application_1/model/cliente.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ClienteScreen extends StatefulWidget { 
  final Cliente? cliente;

  const ClienteScreen({Key? key, this.cliente}) : super(key: key);

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Cliente _cliente;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.cliente != null && _isUpdate == false) {
      _cliente = widget.cliente!;
      _fotoPerfil = _cliente.foto;
      _nomeController.text = _cliente.nome;
      _telefoneController.text = _cliente.telefone;
      _idadeController.text = _cliente.idade.toString();
      _alturaController.text = _cliente.altura.toString();
      _pesoController.text = _cliente.peso.toString();
      _isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fotoAvatar(context),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome obrigatório';
                    }
                    return null;
                  },
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: "NOME",
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Telefone obrigatório';
                    }
                    return null;
                  },
                  controller: _telefoneController,
                  decoration: InputDecoration(
                    labelText: "TELEFONE",
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Idade obrigatória';
                    }
                    return null;
                  },
                  controller: _idadeController,
                  decoration: InputDecoration(
                    labelText: "IDADE",
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatória';
                    }
                    return null;
                  },
                  controller: _alturaController,
                  decoration: InputDecoration(
                    labelText: "ALTURA",
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                    return null;
                  },
                  controller: _pesoController,
                  decoration: InputDecoration(
                    labelText: "PESO",
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      elevation: 5.0,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      int? idade = int.tryParse(_idadeController.text);
                      double? altura = double.tryParse(_alturaController.text);
                      double? peso = double.tryParse(_pesoController.text);

                      if (idade == null || altura == null || peso == null) {
                        debugPrint('Valores inválidos');
                        return;
                      }

                      if (_formKey.currentState?.validate() ?? false) {
                        Cliente c = Cliente(
                          widget.cliente?.id ?? 0,
                          _nomeController.text,
                          _telefoneController.text,
                          idade,
                          altura,
                          peso,
                          _fotoPerfil,
                        );

                        if (widget.cliente != null) {
                          ClienteDAO().atualizar(c);
                          Navigator.of(context).pop();
                        } else {
                          ClienteDAO.adicionar(c);
                          Navigator.of(context).pop();
                        }
                      } else {
                        debugPrint('Formulário inválido');
                      }
                    },
                    child: Text('Salvar',
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        alertTirarFoto(context);
        debugPrint("tirar foto...");
      },
      child: CircleAvatar(
        radius: 70,
        backgroundImage: _fotoPerfil.isNotEmpty
            ? FileImage(File(_fotoPerfil))
            : AssetImage('imagens/camera.png') as ImageProvider,
      ),
    );
  }
  alertTirarFoto(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: Text('FOTO DE PERFIL', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text('ESCOLHA COMO DESEJA SELECIONAR A FOTO'),
      elevation: 5.0,
      actions: [
        InkWell(
          onTap: () {
            debugPrint('CAMERA SELECIONADA');
            _obterImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
          child: Text(
            'CAMERA',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),

        InkWell(
          onTap: () {
            debugPrint('GALERIA SELECIONADA');
            _obterImage(ImageSource.gallery);
            Navigator.of(context).pop();

          },
          child: Text(
            'GALERIA',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        )

      ],
    );

    showDialog(
      context: context, 
      builder: (BuildContext content){
        return alert;
      });
  }

  String _fotoPerfil = '';

  Future<void> _obterImage(ImageSource source) async {
  final XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    debugPrint('Imagem selecionada: ${pickedImage.path}');

    final ImageCropper cropper = ImageCropper();

    final CroppedFile? croppedFile = await cropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: 'CORTAR IMAGEM',
          statusBarColor: Colors.lightBlue,
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(
          title: 'Cortar imagem',
        )
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _fotoPerfil = croppedFile.path;
      });
    } else {
      debugPrint('Imagem cortada foi cancelada.');
    }
    } else {
      debugPrint('Nenhuma imagem selecionada');
    }
  }
}
