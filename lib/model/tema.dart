class Tema {
  int id;
  String titulo;
  String subtitulo;
  List<String> imgs;
  String audio;
  Tema({required this.id, required this.titulo, required this.subtitulo, required this.imgs, required this.audio });
  factory Tema.fromJson(Map<String, dynamic> tema) {
    return Tema(
      id: tema['id'],
      titulo: tema['titulo'],
      subtitulo: tema['subTitulo'],
      imgs: tema["img"] == null ? [] : List<String>.from(tema["img"].map((x) => x)),
      audio: tema["media"],
      
    );
  }
}
