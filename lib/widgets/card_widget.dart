import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/widgets/tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.numero,
      required this.description,
      required this.onTap})
      : super(key: key);
  final String numero;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: AppColors.rosaBase,
        width: ScreenUtil().setWidth(size.width * 0.45),
        height: ScreenUtil().setHeight(size.height * 0.28),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Icon(
                  Icons.music_note,
                  color: AppColors.grisBase,
                ),
              ),
            ),
            InkWell(
              onTap: () => onTap(),
              child: Tarjeta(
                titulo: numero,
                description: description,
                tituloTamanno: ResponsiveValue(
                  context,
                  defaultValue: 50.0,
                  valueWhen: const [
                    
                    Condition.equals(
                      name: TABLET,
                      value: 100.0,
                    )
                  ],
                ).value ?? 0.0,
                descriptionTamano: ResponsiveValue(
                  context,
                  defaultValue: 13.0,
                  valueWhen: const [
                    
                    Condition.equals(
                      name: TABLET,
                      value: 20.0,
                    )
                  ],
                ).value ?? 0.0,
                alineacion: 'right',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
