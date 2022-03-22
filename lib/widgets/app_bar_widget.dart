
import 'package:amalia_musica/stores/font/font_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late FontStore _fontStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fontStore = Provider.of<FontStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ' Universidad de las Artes'.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(22),
                    letterSpacing: 0.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('incremento');
                }
                _fontStore.incrementFontSizeCreditoCargo();
                _fontStore.incrementFontSizeContenido();
                _fontStore.incrementFontSizeBuscadorResultado();
                _fontStore.incrementFontSizeTitulo();
              },
              child: const Icon(
                Icons.zoom_in,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (kDebugMode) {
                print('decremento');
              }
              _fontStore.decrementFontSizeCreditoCargo();
              _fontStore.decrementFontSizeContenido();
              _fontStore.decrementFontSizeBuscadorResultado();
              _fontStore.decrementFontSizeTitulo();
            },
            child: const Center(
              child: Icon(
                Icons.zoom_out,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
