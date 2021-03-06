import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  // el required es para que si o si manden el parametro de la lista de peliculas
  CardSwiper({@required this.peliculas});
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
            ),
          );
        },
        itemCount: peliculas.length,
        itemWidth: _screensize.width * 0.7,
        itemHeight: _screensize.height * 0.5,
        autoplay: true,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
