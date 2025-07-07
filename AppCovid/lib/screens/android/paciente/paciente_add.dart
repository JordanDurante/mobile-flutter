import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/paciente_dao.dart';
import 'package:flutter_application_1/model/paciente.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PacienteScreen extends StatefulWidget {

  final Paciente? paciente;

  const PacienteScreen({Key? key, this.paciente}) : super(key: key);

  @override
  State<PacienteScreen> createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _cartaoController = TextEditingController();

  final TextEditingController _idadeController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Paciente _paciente;

  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {

    debugPrint(_isUpdate.toString());

    if (widget.paciente != null && _isUpdate == false) {
      _paciente = widget.paciente!;
      _fotoPerfil = _paciente.foto;
      _nomeController.text = _paciente.nome;
      _emailController.text = _paciente.email;
      _cartaoController.text = _paciente.cartao;
      _idadeController.text = _paciente.idade.toString();
      _senhaController.text = _paciente.senha;
      _isUpdate = true;
      
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PACIENTE'),
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
                    labelText: "NOME"
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Email obrigatório';
                    }
                    return null;
                  } ,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "EMAIL"
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Cartão SUS obrigatório';
                    }
                    return null;
                  } ,
                  controller: _cartaoController,
                  decoration: InputDecoration(
                    labelText: "CARTÂO SUS"
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Idade obrigatório';
                    }
                    return null;
                  } ,
                  controller: _idadeController,
                  decoration: InputDecoration(
                    labelText: "IDADE"
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Senha obrigatório';
                    }
                    return null;
                  } ,
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: "SENHA"
                  ),
                  style: TextStyle(fontSize: 20),
                  obscureText: true,
                ),
                Container(
                  // color: Colors.red,
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
                      if (idade == null) {
                        debugPrint('Idade inválida');
                        return;
                      }
                      if(_formKey.currentState?.validate() ?? false){
                        Paciente p = Paciente(
                          widget.paciente?.id ?? 0,
                          _nomeController.text,
                          _emailController.text,
                          _cartaoController.text,
                          idade,
                          _senhaController.text,
                          _fotoPerfil
                        );
                        if(widget.paciente != null){
                          PacienteDAO().atualizar(p);
                          Navigator.of(context).pop();
                        }else{
                          PacienteDAO.adicionar(p);
                          Navigator.of(context).pop();
                        }
                        
                      }else{
                        debugPrint('Formulário inválido');
                      }
                    },
                    child: Text('Salvar', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                )
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