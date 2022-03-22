import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/ui/visor_tema.dart';
import 'package:amalia_musica/widgets/partichuela_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PartichelaScreen extends StatefulWidget {
  const PartichelaScreen(
      {Key? key, required this.homeAnimation, required this.onTap})
      : super(key: key);
  final Animation<double> homeAnimation;
  final VoidCallback onTap;

  @override
  _PartichelaScreenState createState() => _PartichelaScreenState();
}

class _PartichelaScreenState extends State<PartichelaScreen> {
  late ContenidoStore _contenidoStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Contenido> contenidosSeleccionados =
        _contenidoStore.contenidos.where((Contenido c) {
      return c.tema.id == _contenidoStore.selectedTema.id;
    }).toList();

    return Scaffold(
       appBar: AppBar(
            backgroundColor: AppColors.rosaBase,
          ),
           extendBody: true,
          resizeToAvoidBottomInset: false,
      body: Container(
         padding: const EdgeInsets.all(5),
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home2.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Container(
            width: size.width * 0.9,
            height: 20,
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.rosaBase,
                        width: 3.0,
                        style: BorderStyle.solid)),
                margin: const EdgeInsets.only(top: 50.0),
    
          ),
          Positioned(
            top: 0.14 * size.height,
            left: 0.23 * size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.grisBase,
                      ),
                    ),
                  ),
                  Text(
                    _contenidoStore.selectedTema.id.toString() + '. ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                      letterSpacing: 0.2,
                      color: AppColors.grisBase,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: AutoSizeText(
                      _contenidoStore.selectedTema.titulo.toUpperCase(),
                      maxLines: 2,
                      minFontSize: ScreenUtil().setSp(18),
                      stepGranularity: ScreenUtil().setSp(1),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(20),
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                  ),
                ]),
          ),
          Positioned(
            top: 0.29 * size.height,
            left: 0.35 * size.width,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return FadeTransition(
                            opacity: animation1,
                            child: const VisorTemaScreen(),
                          );
                        },
                        transitionDuration: const Duration(seconds: 1)));
                  },
                  child: Text(
                    'Partitura',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(28),
                      letterSpacing: 0.2,
                      color: AppColors.grisBase,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.42 * size.height,
            left: 0.2 * size.width,
            child: Container(
                width: 0.6 * size.width,
                child: Observer(builder: (_) {
                  return Observer(builder: (_) {
                    return Observer(builder: (_) {
                      return Partichela(
                        contenidos: contenidosSeleccionados,
                      );
                    });
                  });
                })),
          ),
        
        ],)
      ),
    );
  }
}
