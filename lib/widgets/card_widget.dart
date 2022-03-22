import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/widgets/tarjeta.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.numero, required this.description, required this.onTap})
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
        width: size.width * 0.45,
        height: size.height * 0.27,
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
                tituloTamanno: 70,
                descriptionTamano: 18,
                alineacion: 'right',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
