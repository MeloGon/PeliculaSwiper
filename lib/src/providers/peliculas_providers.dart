import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas_app/src/models/pelicula_model.dart';

import '../models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '69b81bc75eac4a9d7ae99fa81b16b130';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  //vamos a evitar que se carguen las 900 peliculas apara ahorrar solicitudes http y no gasten demasiados datos
  bool _cargando = false;
  List<Pelicula> _populares = new List();

  //codigo para crear un stream
  //si no se pone el broadcaste funcioan como un singlelistener con el boradcast es para que tenga muchos listeners
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //regla que mi funcion debe de cumplir, sink es la entrada de informacion
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    //donde no se inicialice el streamController lo cual no pasa aqui
    //por esa razon se le pone el simbolo de interrogacion
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;
    print('cargando siguientes');
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }
}
