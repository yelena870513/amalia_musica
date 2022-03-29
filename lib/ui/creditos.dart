import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/constants/font_family.dart';
import 'package:amalia_musica/constants/strings.dart';
import 'package:amalia_musica/widgets/line_horizontal_gruesa.dart';
import 'package:amalia_musica/widgets/tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditosScreen extends StatelessWidget {
  const CreditosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: ScreenUtil().setWidth(size.width * 0.9),
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.rosaBase,
                      width: 3.0,
                      style: BorderStyle.solid)),
              child: Center(
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
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: CustomPaint(
                  painter: LineaHorizontalGruesa(
                      3, const Offset(-20.0, 0.0), const Offset(20.0, 0.0)))),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(size.height * 0.7),
            child: Center(
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.vertical,
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
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'Proveedor de contenidos',
                      description: 'Jorge Félix Leyva García',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'Diseño',
                      description: 'Jeniffer Lucia Muñiz Márquez',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'Programación',
                      description: 'Yelena Islen San Juan',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'Control de calidad',
                      description: 'Maylen Gesen Gallinal',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'Gestión de la calidad y auditoría',
                      description: 'Mercedes María Sosa Hernández',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      'Ivett Muñoz Ramírez'.toUpperCase(),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        letterSpacing: 0.2,
                        color: AppColors.grisBase,
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Tarjeta(
                      titulo: 'ISBN',
                      description: '978-959-315-257-0',
                      tituloTamanno: 20,
                      descriptionTamano: 14,
                      alineacion: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
