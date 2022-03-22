import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/model/favorito_model.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/widgets/card_widget_favoritos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:amalia_musica/ui/visor.dart';

class FavoritoScreen extends StatefulWidget {
  const FavoritoScreen({Key? key}) : super(key: key);

  @override
  _FavoritoScreenState createState() => _FavoritoScreenState();
}

class _FavoritoScreenState extends State<FavoritoScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late var favoritos;
  late ContenidoStore _contenidoStore;

  void seleccionarContenido(int id) {
    _contenidoStore.setIdContenidoSeleccionado(id);
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: const VisorScreen(),
          );
        },
        transitionDuration: const Duration(seconds: 1)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.watch<FavoritoModel>().getItem();
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Consumer<FavoritoModel>(builder: (context, model, child) {
      final bool hayFavorito = model.favoritoList.isNotEmpty;
      List<Contenido> contenidos =
        _contenidoStore.contenidos.where((Contenido element) {
      return model.favoritoList.contains(element.id) == true;
    }).toList();

      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.rosaBase,
                        width: 3.0,
                        style: BorderStyle.solid)),
                margin: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Text(
                    Strings.favoritos,
                    style: TextStyle(
                      fontFamily: FontFamily.bodoniFLF,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(36),
                      color: AppColors.grisBase,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: size.width,
                height: size.height * 0.6,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: 
                  hayFavorito?
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      for (var i = 0; i < contenidos.length; i ++)
                        InkWell(
                          onTap: () {
                            seleccionarContenido(contenidos[i].id);
                          },
                          child: CardWidgetFavoritos(
                            contenidoId: contenidos[i].id,
                            numero: contenidos[i].tema.id.toString() + '.',
                            description: contenidos[i].tema.titulo +
                                '\n ' +
                                contenidos[i].titulo,
                          ),
                        ),
                    ],
                  ):
                  Text(
                    Strings.resultFavorito,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.helvetica,
                      color: AppColors.grisBase,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w600,


                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
