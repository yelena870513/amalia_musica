import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'line_horizontal.dart';

class TarjetaFavorito extends StatelessWidget {
  final String titulo;
  final String description;
  final int tituloTamanno;
  final int descriptionTamano;
  final String alineacion;
  const TarjetaFavorito({
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
        Container(
          width: 300,
          height: 70,
          padding: const EdgeInsets.all(7.0),
          child: Align(
            alignment: getAlign(alineacion),
            child: AutoSizeText(
              titulo,
              maxLines: 3,
              minFontSize: ScreenUtil().setSp(14),
              stepGranularity: ScreenUtil().setSp(1),
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
        CustomPaint(painter: LineaHorizontal()),
        Container(
          width: 300,
          height: 70,
          padding: const EdgeInsets.all(7.0),
          child: AutoSizeText(description.toUpperCase(),
              maxLines: 3,
              minFontSize: ScreenUtil().setSp(12),
              stepGranularity: ScreenUtil().setSp(1),
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
