import 'package:amalia_musica/constants/colors.dart';
import 'package:amalia_musica/model/favorito_model.dart';
import 'package:amalia_musica/widgets/tarjeta_favorito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidgetFavoritos extends StatelessWidget {
  const CardWidgetFavoritos(
      {Key? key,
      required this.numero,
      required this.description,
      required this.contenidoId})
      : super(key: key);
  final String numero;
  final String description;
  final int contenidoId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<FavoritoModel>(
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: AppColors.rosaBase,
            width: size.width * 0.37,
            height: size.height * 0.27,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      final int position = model.favoritoList.indexOf(contenidoId);
                      model.deleteItem(position);
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.grisBase,
                    ),
                  ),
                ),
                InkWell(
                  child: TarjetaFavorito(
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
      },
    );
  }
}
