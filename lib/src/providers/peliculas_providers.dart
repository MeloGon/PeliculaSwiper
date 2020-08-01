import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '69b81bc75eac4a9d7ae99fa81b16b130';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    // fromjsonlist segun el modelo barrera con cada una de las peliculas y creara una instancia
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    // print(peliculas.items[9].title);

    return peliculas.items;
  }
}
