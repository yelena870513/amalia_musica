import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'line_horizontal.dart';

class Tarjeta extends StatelessWidget {
  final String titulo;
  final String description;
  final int tituloTamanno;
  final int descriptionTamano;
  String alineacion;
  Tarjeta({
    Key? key,
    required this.titulo,
    required this.description,
    required this.tituloTamanno,
    required this.descriptionTamano,
    required this.alineacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Align(
            alignment: getAlign(alineacion),
            child: Text(
              titulo,
              style: TextStyle(
                fontFamily: FontFamily.bodoniFLF,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(tituloTamanno),
                letterSpacing: 0.2,
                color: AppColors.grisBase,
              ),
            ),
          ),
        ),
        CustomPaint(
          painter: LineaHorizontal()
          ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(description.toUpperCase(),
              textAlign: getTextAlign(alineacion),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(descriptionTamano),
              )),
        )
      ],
    );
  }

  Alignment getAlign(String alineacion) {
    switch (alineacion) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  TextAlign getTextAlign(String alineacion) {
    switch (alineacion) {
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }
}
