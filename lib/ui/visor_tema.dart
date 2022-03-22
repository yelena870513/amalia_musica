import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/widgets/bounce_tab_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:just_audio/just_audio.dart';


class VisorTemaScreen extends StatefulWidget {
  const VisorTemaScreen({Key? key}) : super(key: key);

  @override
  _VisorTemaScreenState createState() => _VisorTemaScreenState();
}

class _VisorTemaScreenState extends State<VisorTemaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _homeAnimation;
  final _player = AudioPlayer();
  int  _currentIndex = 0;

  //stores:---------------------------------------------------------------------
 
  late ContenidoStore _contenidoStore;  

 void cargarPlayer() async {
    try {
      String audio = _contenidoStore.selectedTema.audio;
      await _player.setAsset("assets/audio/" + audio);     
    } catch (e) {
      print("Error loading audio source: $e");
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
     cargarPlayer();
  } 
  @override
  void dispose() {
    _animationController.dispose();
    _player.dispose();
    super.dispose();
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
    const double toolbarHeight = kToolbarHeight + 50;
    final query = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
        BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        context: context,
        designSize: size,
        minTextAdapt: true,
        orientation: Orientation.portrait);
        
    List<String> images = _contenidoStore.selectedTema.imgs;
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.4),
      ),
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
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
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: FadeTransition(
                                  opacity: _homeAnimation,
                                  child: CarouselSlider.builder(
                                    itemCount: images.length,
                                    itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) =>
                                        Container(
                                      child: Image.asset(
                                        'assets/images/' + images[itemIndex],
                                        fit: BoxFit.cover,
                                        height: 0.8 * height,
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: 0.8 * height,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
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
             setState(() {
                      _currentIndex = index;
                    });
                    switch(index){
                      case 0: _player.pause(); break;
                      case 1: _player.play(); break;
                      case 2: _player.stop(); break;
                    }
            },
            backgroundColor: AppColors.rosaBase,
            items: const <Widget>[
              InkWell(
                child: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),InkWell(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),InkWell(
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
