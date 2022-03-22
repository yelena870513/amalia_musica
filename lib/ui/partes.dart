// ignore_for_file: prefer_const_constructors
import 'package:amalia_musica/model/tema.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/widgets/card_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PartesScreen extends StatefulWidget {
  const PartesScreen({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  _PartesScreenState createState() => _PartesScreenState();
}

class _PartesScreenState extends State<PartesScreen> {
  late ContenidoStore _contenidoStore;

  List<Widget> contruirPartes(List<Tema> temas) {
    List<Row> rows = <Row>[];
    for (var i = 0; i < temas.length - 1; i += 2) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardWidget(
            numero: temas[i].id.toString() + '.',
            description: temas[i].titulo,
            onTap: widget.onTap,
          ),
          CardWidget(
            numero: temas[i + 1].id.toString() + '.',
            description: temas[i + 1].titulo,
            onTap: widget.onTap,
          )
        ],
      ));
    }
    return rows;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Tema> temas = _contenidoStore.temas;
    print("Temas ${temas.length}");
    print("Contenidos ${_contenidoStore.contenidos.length}");
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/partes.jpg'),
                fit: BoxFit.contain)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.0),
            for (var i = 0; i < temas.length - 1; i += 2)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardWidget(
                    numero: temas[i].id.toString() + '.',
                    description: temas[i].titulo,
                    onTap: () {
                      _contenidoStore.setSelectedTema(temas[i]);
                      widget.onTap();
                    },
                  ),
                  CardWidget(
                    numero: temas[i + 1].id.toString() + '.',
                    description: temas[i + 1].titulo,
                    onTap: () {
                      _contenidoStore.setSelectedTema(temas[i + 1]);
                      widget.onTap();
                    },
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
