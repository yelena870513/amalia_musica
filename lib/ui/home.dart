import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/model/tema.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/ui/intro.dart';
import 'package:amalia_musica/ui/partes.dart';
import 'package:amalia_musica/ui/partichela.dart';
import 'package:amalia_musica/widgets/bounce_tab_bar.dart';
import 'package:amalia_musica/widgets/tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'favoritos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _homeAnimation;
  late final VoidCallback onBackButtonTap;

  //stores:---------------------------------------------------------------------
  int _currentIndex = 0;
  late ContenidoStore _contenidoStore;
  bool _isPartesActive = true;

  Widget getCurrentScreen(Size size) {
    if (_isPartesActive == true) {
      return PartesScreen(
        onTap: setCurrentScreen,
      );
    } else {
      return PartichelaScreen(
          homeAnimation: _homeAnimation, onBackButtonTap: resetCurrentIndex);
    }
  }

  void setCurrentScreen() {
    setState(() {
      _isPartesActive = !_isPartesActive;
    });
  }

  void resetCurrentIndex() {
    setState(() {
     _isPartesActive = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    _homeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
  }

  Future<int> getContenidos() async {
    List<Contenido> contenidos = await _contenidoStore.getContenidos();
    List<Tema> temas = await _contenidoStore.getTemas();
    return contenidos.length + temas.length;
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    List<Contenido> contenidos = _contenidoStore.contenidos.toList();
    return FutureBuilder(
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.data != null) {
          return MediaQuery(
            data: query.copyWith(
              textScaleFactor: query.textScaleFactor.clamp(1.0, 1.4),
            ),
            child: Theme(
              data: ThemeData.light(),
              child: Scaffold(
                extendBody: true,
                resizeToAvoidBottomInset: false,
                body: IndexedStack(
                  index: _currentIndex,
                  children: <Widget>[
                    const IntroScreen(),
                    const FavoritoScreen(),
                    Container(
                      child: getCurrentScreen(size),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: size.width * 0.9,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.rosaBase,
                                      width: 2.0,
                                      style: BorderStyle.solid)),
                              child: Text(
                                Strings.creditos,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.bodoniFLF,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(36),
                                  letterSpacing: 0.2,
                                  color: AppColors.grisBase,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Tarjeta(
                                  titulo: 'Dirección de proyecto',
                                  description: 'Yanet Cabargas Fernnández',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Tarjeta(
                                  titulo: 'Proveedor de contenidos',
                                  description: 'Amalia Simoni',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Tarjeta(
                                  titulo: 'Diseño',
                                  description: 'Jeniffer Lucia Muñiz Márquez',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Tarjeta(
                                  titulo: 'Programación',
                                  description: 'Yelena Islen San Juan',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Tarjeta(
                                  titulo: 'Control de calidad',
                                  description: 'Mailen Maribal',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Tarjeta(
                                  titulo: 'Gestión de la calidad y auditoría',
                                  description: 'Mercedes María Sosa Hernández',
                                  tituloTamanno: 20,
                                  descriptionTamano: 14,
                                  alineacion: '',
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  'Ivett Muñoz Ramírez'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    letterSpacing: 0.2,
                                    color: AppColors.grisBase,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BounceTabBar(
                  key: UniqueKey(),
                  initialIndex: _currentIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _isPartesActive = true;
                    });
                  },
                  backgroundColor: AppColors.rosaBase,
                  items: const <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.home_filled,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.people_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
      future: getContenidos(),
    );
  }
}
