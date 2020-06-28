import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:simpleApp/src/app/pages/home/home_presenter.dart';
import 'package:simpleApp/src/domain/entities/movie.dart';

class HomeController extends Controller {
  Result _movie;

  Result get data => _movie;

  final HomePresenter homePresenter;

  HomeController(movieRepo)
      : homePresenter = HomePresenter(movieRepo),
        super();

  @override
  void initListeners() {
    homePresenter.getMovieOnNext = (Result movie) {
      _movie = movie;
      refreshUI();
    };
    homePresenter.getMovieOnComplete = () {
      print('Movie fetch completed');
    };
    homePresenter.getMovieOnError = (e) {
      print('Could not fetch movies');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.toString())));
      _movie = null;
      refreshUI();
    };
  }

  void getMovie() => homePresenter.getMovie('3257eb16ba7458abb70f3604b3ba6341');

  @override
  void onResumed() {
    print('On resumed');
    super.onResumed();
  }

  @override
  void dispose() {
    homePresenter.dispose();
    super.dispose();
  }
}
