import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/model/favorito_model.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/widgets/bounce_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class VisorScreen extends StatefulWidget {
  const VisorScreen({Key? key}) : super(key: key);

  @override
  _VisorScreenState createState() => _VisorScreenState();
}

class _VisorScreenState extends State<VisorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _homeAnimation;
  late final VoidCallback onBackButtonTap;

  //stores:---------------------------------------------------------------------
  late ContenidoStore _contenidoStore;
  final _player = AudioPlayer();
  bool _isFavorite = false;

  void cargarPlayer() async {
    try {
      String audio = _contenidoStore.selectedTema.audio;
      await _player.setAsset("assets/audio/" + audio);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  _actualizarFavoritos(int contenido) {
    var favoritoBD = Provider.of<FavoritoModel>(context, listen: false);
    List favoritos = favoritoBD.favoritoList;
    if (favoritos.contains(contenido)) {
      int position = favoritos.indexOf(contenido);
      favoritoBD.deleteItem(position);
    } else {
      favoritoBD.addItem(contenido);
    }
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
  void dispose() {
    _animationController.dispose();
    _player.dispose();
    //Hive.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
    cargarPlayer();
    final Box box = Hive.box<int>(Strings.favoritos);
    List favs = box.values.toList();
    int contenidoId = _contenidoStore.idContenidoSeleccionado;
    if (favs.contains(contenidoId)) {
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    List<Contenido> contenidos = _contenidoStore.contenidos.toList();
    int idContenidoSeleccionado = _contenidoStore.idContenidoSeleccionado;
    Contenido contenido = contenidos
        .where((Contenido c) {
          return c.id == idContenidoSeleccionado;
        })
        .toList()
        .first;
    List<String> images = contenido.imgs;
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.4),
      ),
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              _actualizarFavoritos(contenido.id);
            },
            backgroundColor: AppColors.rosaBase,
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: AppColors.grisBase,
            ),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.rosaBase,
          ),
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: images.isNotEmpty
              ? Stack(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: kToolbarHeight - 150,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: FadeTransition(
                                  opacity: _homeAnimation,
                                  child: PhotoViewGallery.builder(
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.white
                                    ),
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    itemCount: images.length,
                                    builder:
                                        (BuildContext context, int itemIndex) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider: AssetImage(
                                            'assets/images/' +
                                                images[itemIndex]),
                                        initialScale:
                                            PhotoViewComputedScale.contained,
                                        heroAttributes: PhotoViewHeroAttributes(
                                            tag: images[itemIndex]),
                                      );
                                    },
                                    loadingBuilder: (context, event) => const Center(
                                      child: SizedBox(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: BounceTabBar(
            initialIndex: 2,
            onTabChanged: (index) {
              switch (index) {
                case 0:
                  _player.pause();
                  break;
                case 1:
                  _player.play();
                  print('play');
                  break;
                case 2:
                  _player.stop();
                  break;
              }
            },
            backgroundColor: AppColors.rosaBase,
            items: const <Widget>[
              InkWell(
                child: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.stop,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
