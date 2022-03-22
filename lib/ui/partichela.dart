import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
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
      {Key? key, required this.homeAnimation, required this.onBackButtonTap})
      : super(key: key);
  final Animation<double> homeAnimation;
  final VoidCallback onBackButtonTap;

  @override
  State<PartichelaScreen> createState() => _PartichelaScreenState();
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
        leading: BackButton(
          onPressed: widget.onBackButtonTap,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home3.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.9,
              height: 80,
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.rosaBase,
                      width: 3.0,
                      style: BorderStyle.solid)),
              margin: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _contenidoStore.selectedTema.id.toString() + '. ',
                      style: TextStyle(
                        fontFamily: FontFamily.bodoniFLF,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(40),
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                    SizedBox(
                      width: 1.0,
                    ),
                    Text(
                      _contenidoStore.selectedTema.titulo.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(20),
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 90,
              width: size.width * 0.90,
              padding: EdgeInsets.only(top: 25.0),
              color: AppColors.rosaBase,
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
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 60.0),
              width: size.width * 0.90,
              color: AppColors.rosaBase,
              child: SizedBox(
                  width: 0.6 * size.width,
                  child: Partichela(
                    contenidos: contenidosSeleccionados,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
