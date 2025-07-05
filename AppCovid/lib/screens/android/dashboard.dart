import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/android/login_screen.dart';
import 'package:flutter_application_1/screens/android/paciente/paciente_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login()
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _msgSuperiorTXT(),
            _imgCentral(),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _ItemElemento('PACIENTES', Icons.accessibility_new, (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PacienteList()
                    ));
                  }),
                  _ItemElemento('RESULTADOS', Icons.check_circle_outline, (){
                    debugPrint('resultados');
                  }),
                ],

              ),
            )
            
          ],
        ),
      ),
    );
  }

  Widget _imgCentral() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('imagens/image.jpg'),
    );
  }

  Widget _msgSuperiorTXT() {
    return Container(
      // color: Colors.blue,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(8.0),
      child: Text('Checklist para Covid-19', style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
      ),),
    );
  }
}

class _ItemElemento extends StatelessWidget {

  final String titulo;
  final IconData icone;
  final VoidCallback  onClick;

  const _ItemElemento(this.titulo, this.icone, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.blue[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)
        ),
        elevation: 10.0,
        child: InkWell(
          onTap: onClick,
          child: Container(
            // color: Colors.green,
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(this.icone, 
                  color: Colors.white,
                ),
                Text(this.titulo, style: TextStyle(
                  color: Colors.white, fontSize: 16
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}