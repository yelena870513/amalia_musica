import 'dart:async';
import 'dart:convert';
import 'package:amalia_musica/model/contenido.dart';
import 'package:amalia_musica/model/tema.dart';
import 'package:flutter/services.dart';

class ContentDataSource {
  late Map<String, dynamic> _contenidoData;
  static List<Contenido> contenidos = List.empty(growable: true);
  static List<Tema> temas = List.empty(growable: true);

  Future<bool> loadData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/amalia_contenido.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _contenidoData = jsonMap;
    List<dynamic> mappedContenido = _contenidoData['contenido'];
    contenidos = mappedContenido.map((f) => Contenido.fromJson(f)).toList();

    List<dynamic> mappedTema = _contenidoData['tema'];
    temas = mappedTema.map((f) => Tema.fromJson(f)).toList();

    return true;
  }
}
