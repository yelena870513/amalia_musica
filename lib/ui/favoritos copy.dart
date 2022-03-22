import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/widgets/card_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:amalia_musica/ui/visor.dart';

class FavoritoScreen extends StatefulWidget {
  const FavoritoScreen({Key? key, required this.onBackButtonTap})
      : super(key: key);

  final VoidCallback onBackButtonTap;

  @override
  _FavoritoScreenState createState() => _FavoritoScreenState();
}

class _FavoritoScreenState extends State<FavoritoScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late var favoritos;
  late ContenidoStore _contenidoStore;
  List<int> favs = [];

  void obtenerFavoritos() async {
    final box = Hive.box<int>(Strings.favoritos);
    setState(() {
      favs = box.values.toList();
    });
  }

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
    final box = Hive.box<int>(Strings.favoritos);
    setState(() {
      favs = box.values.toList();
    });
  }

  @override
  void initState() {
    obtenerFavoritos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    print(favs);
    List<Contenido> contenidos =
        _contenidoStore.contenidos.where((Contenido element) {
      return favs.contains(element.id) == true;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 60.0),
            Container(
               height: size.height * 0.6,
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                     for (var i = 0; i < contenidos.length - 1; i += 2)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardWidget(
                      numero: contenidos[i].tema.id.toString() + '.',
                      description: contenidos[i].tema.titulo +
                          '\n ' +
                          contenidos[i].titulo,
                      onTap: () {
                        seleccionarContenido(contenidos[i].id);
                      },
                    ),
                    CardWidget(
                      numero: contenidos[i + 1].tema.id.toString() + '.',
                      description: contenidos[i + 1].tema.titulo +
                          '\n ' +
                          contenidos[i].titulo,
                      onTap: () {
                        seleccionarContenido(contenidos[i + 1].id);
                      },
                    )
                  ],
                ),
                        
                  ],
                ),
              ),
            )
           ],
        ),
      ),
    );
  }
}
