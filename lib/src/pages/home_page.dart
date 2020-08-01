import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_providers.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          //el progrssar solo aparece mientras se resuleve el future o cuando nohay datos
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
    // peliculasProvider.getEnCines();
    // return CardSwiper(
    //   peliculas: [1, 2, 3, 4, 5],
    // );
  }
}
