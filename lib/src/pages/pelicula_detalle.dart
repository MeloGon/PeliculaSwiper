import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      //sliver son widgets que reaccionan con el scroll
      body: CustomScrollView(
        slivers: [
          _crearAppbar(pelicula),
          //este sliverlist es pareceido a un listview
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
          ]))
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200, //que tan ancho sea ya expandido
      floating: false,
      pinned: true, //se mantiene visible cuando hago scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ), //recibe un widget que se adapta
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          //el flexible widget que controla como los hijos de un row se despliega
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pelicula.originalTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString()),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
