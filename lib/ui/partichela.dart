import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/ui/visor_tema.dart';
import 'package:amalia_musica/widgets/line_horizontal_gruesa.dart';
import 'package:amalia_musica/widgets/partichuela_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
        width: ScreenUtil().setWidth(size.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(size.width * 0.9),
              height: ScreenUtil().setWidth(80),
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
                        fontSize: ResponsiveValue(
                              context,
                              defaultValue: ScreenUtil().setSp(30),
                              valueWhen: const [
                                Condition.equals(
                                  name: TABLET,
                                  value: 45.0,
                                )
                              ],
                            ).value ??
                            0.0,
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                    const SizedBox(
                      width: 1.0,
                    ),
                    Text(
                      _contenidoStore.selectedTema.titulo.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: ResponsiveValue(
                              context,
                              defaultValue: ScreenUtil().setSp(18),
                              valueWhen: const [
                                Condition.equals(
                                  name: TABLET,
                                  value: 28.0,
                                )
                              ],
                            ).value ??
                            0.0,
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPaint(
                painter: LineaHorizontalGruesa(
                    3, const Offset(-20.0, 0.0), const Offset(20.0, 0.0))),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: ScreenUtil().setHeight(90),
              width: ScreenUtil().setWidth(size.width * 0.90),
              padding: const EdgeInsets.only(top: 25.0),
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
                        fontSize: ResponsiveValue(
                  context,
                  defaultValue: ScreenUtil().setSp(25),
                  valueWhen: const [
                    
                    Condition.equals(
                      name: TABLET,
                      value: 30.0,
                    )
                  ],
                ).value ?? 0.0,
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
              padding: const EdgeInsets.only(left: 23.0),
              width: ScreenUtil().setWidth(size.width * 0.90),
              color: AppColors.rosaBase,
              child: SizedBox(
                  width: ScreenUtil().setWidth(0.5 * size.width),
                  child: Partichela(
                    contenidos: contenidosSeleccionados,
                  )),
            ),
            SizedBox(
            height: ResponsiveValue(
                  context,
                  defaultValue: 100.0,
                  valueWhen: const [
                    
                    Condition.equals(
                      name: TABLET,
                      value: 380.0,
                    )
                  ],
                ).value ?? 0.0,
          ),
          CustomPaint(
              painter: LineaHorizontalGruesa(
                  1.45, const Offset((-800), 0.0), const Offset(800, 0.0))),
          ],
        ),
      ),
    );
  }
}
