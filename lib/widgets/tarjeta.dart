import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'line_horizontal_gruesa.dart';

class Tarjeta extends StatelessWidget {
  final String titulo;
  final String description;
  final double tituloTamanno;
  final double descriptionTamano;
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
          padding: const EdgeInsets.all(3.0),
          child: Align(
            alignment: getAlign(alineacion),
            child: AutoSizeText(
              titulo,
              maxLines: 4,
              minFontSize: ScreenUtil().setSp(9),
              stepGranularity: ScreenUtil().setSp(0.1),
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
            painter: LineaHorizontalGruesa(
                1,
                Offset(
                    ResponsiveValue(
                          context,
                          defaultValue: 50.0,
                          valueWhen: const [
                            Condition.equals(
                              name: TABLET,
                              value: 100.0,
                            )
                          ],
                        ).value ??
                        0.0,
                    0.0),
                Offset(
                    ResponsiveValue(
                          context,
                          defaultValue: -50.0,
                          valueWhen: const [
                            Condition.equals(
                              name: TABLET,
                              value: -100.0,
                            )
                          ],
                        ).value ??
                        0.0,
                    0.0))),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: AutoSizeText(description.toUpperCase(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              minFontSize: ScreenUtil().setSp(8),
              stepGranularity: ScreenUtil().setSp(0.5),
              textAlign: getTextAlign(alineacion),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(descriptionTamano),
              ),),
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
