import 'dart:math' as math;
import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/stores/data/contenido_store.dart';
import 'package:amalia_musica/ui/visor.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Partichela extends StatefulWidget {
  final List<Contenido> contenidos;
  

  const Partichela({Key? key, required this.contenidos}) : super(key: key);

  @override
  State<Partichela> createState() => _PartichelaState();
}

class _PartichelaState extends State<Partichela> {
  late ContenidoStore _contenidoStore;
  
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contenidoStore = Provider.of<ContenidoStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    buildItem(String label, int id) {
      return Container(
        width: 250,
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              //                   <--- left side
              color: Colors.white,
              width: 8.0,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: InkWell(
            onTap: () {
              _contenidoStore.setIdContenidoSeleccionado(id);
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return FadeTransition(
                      opacity: animation1,
                      child: const VisorScreen(),
                    );
                  },
                  transitionDuration: const Duration(seconds: 1)));
            },
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(22),
                letterSpacing: 0.2,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    buildList() {
      return Center(
        child: Container(
          color: AppColors.grisBase,
          child: SingleChildScrollView(
              child: Container(
            height: 220,
            child: ListView.builder(
                physics: const PageScrollPhysics(),
                itemCount: widget.contenidos.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext contex, int index) {
                  return buildItem(widget.contenidos[index].titulo, widget.contenidos[index].id);
                }),
          )),
        ),
      );
    }

    return ExpandableNotifier(
      key: UniqueKey(),
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          color: AppColors.grisBase,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: AppColors.rosaBase,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_drop_down,
                            collapseIcon: Icons.arrow_drop_up,
                            iconColor: Colors.white,
                            iconSize: 40.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: true,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Partichela',
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
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
