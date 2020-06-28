import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:simpleApp/src/app/pages/home/home_controller.dart';
import 'package:simpleApp/src/data/repository/data_movie_repository.dart';
import 'package:simpleApp/src/domain/entities/movie.dart';

class HomePage extends View {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataMovieRepository()));

  @override
  Future<void> initState() {
    super.initState();
    controller.getMovie();
  }

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(text: "Popular Movies", style: TextStyle(fontSize: 25)),
            WidgetSpan(child: Icon(Icons.movie)),
          ]),
        ),
        //title: Text('Popular Movies', textAlign: TextAlign.center),
      ),
      body: controller.data == null
          ? showCircularProgress()
          : showMovieList(controller),
    );
  }

  Widget showCircularProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget showMovieList(HomeController controller) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: controller.data.moviesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Text("${controller.data.moviesList[index].title}",
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  overflow: TextOverflow.ellipsis),
              Divider(
                height: 10,
                thickness: 5,
              ),
              SizedBox(height: 5, width: 50),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            showMovieDetailsDialog(
                                context, controller.data.moviesList[index]))
                  },
                  child: GridTile(
                    key: (Key('movieImage')),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185${controller.data.moviesList[index].poster_path}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5, width: 50),
            ],
          );
        });
  }

  Widget showMovieDetailsDialog(BuildContext context, Movie movie) {
    return AlertDialog(
      title: Text(movie.title, textAlign: TextAlign.center),
      content: Container(
        child: Column(
          children: <Widget>[
            Divider(thickness: 5),
            SizedBox(height: 5),
            Image(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w185${movie.poster_path}'),
              width: 100,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 25),
            Text(movie.overview, maxLines: 5, overflow: TextOverflow.ellipsis),
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Rating: ${movie.vote_average}/10"),
                Text("Release Date: ${movie.release_date}"),
                Text("Language: ${movie.original_language}"),
                SizedBox(
                  height: 3,
                ),
                Row(children: <Widget>[
                  Icon(Icons.thumb_up, size: 16),
                  Text(" ${movie.vote_count} "),
                ]),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => {Navigator.of(context).pop()},
            color: Colors.green,
            child: const Text('Close'))
      ],
    );
  }
}
