import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/model/tema.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/ui/intro.dart';
import 'package:amalia_musica/ui/partes.dart';
import 'package:amalia_musica/ui/partichela.dart';
import 'package:amalia_musica/widgets/bounce_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'creditos.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    IntroScreen(key: _scaffoldKey,),
                    const FavoritoScreen(),
                    Container(
                      child: getCurrentScreen(size),
                    ),
                    CreditosScreen(key: UniqueKey(),) ],
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
                  items: <Widget>[
                    InkWell(                      
                      child: _currentIndex == 0
                          ? Image.asset('assets/iconos/intro_OFF.png', width: 40, height: 40)
                          : Image.asset('assets/iconos/intro_ON.png', width: 40, height: 40),
                          
                    ),
                    InkWell(
                      child: _currentIndex == 1
                          ? Image.asset('assets/iconos/favorito_ON.png', width: 40, height: 40)
                          : Image.asset('assets/iconos/favorito_OFF.png', width: 40, height: 40),
                      ),                    
                    InkWell(
                      child:  _currentIndex == 2
                          ? Image.asset('assets/iconos/menu_ON.png', width: 40, height: 40)
                          : Image.asset('assets/iconos/menu_OFF.png', width: 40, height: 40),
                    ),
                    InkWell(
                      child:  _currentIndex == 3
                          ? Image.asset('assets/iconos/creditos_ON.png', width: 40, height: 40)
                          : Image.asset('assets/iconos/creditos_OFF.png', width: 40, height: 40),
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
