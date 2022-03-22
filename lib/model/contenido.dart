

import 'package:amalia_musica/model/tema.dart';

class Contenido {
  int id;
  int orden;
  String titulo;
  String texto;
  Tema tema;
  List<String> imgs;

  Contenido(
      {required this.id,
      required this.orden,
      required this.titulo,
      required this.texto,
      required this.tema,
      required this.imgs});

  factory Contenido.fromJson(Map<String, dynamic> contenido) {
    return Contenido(
      id: contenido['id'],
      orden: contenido['orden'],
      titulo: contenido['titulo'],
      texto: contenido['texto'],
      tema: Tema.fromJson(contenido['tema']),
      imgs: contenido["img"] == null ? [] : List<String>.from(contenido["img"].map((x) => x)),
    );
  }
}
