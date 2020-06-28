import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:simpleApp/src/domain/usercases/get_movie_usercase.dart';

class HomePresenter extends Presenter {
  Function getMovieOnNext;
  Function getMovieOnComplete;
  Function getMovieOnError;

  final GetMovieUseCase getMovieUseCase;

  HomePresenter(movieRepo) : getMovieUseCase = GetMovieUseCase(movieRepo);

  void getMovie(String apiKey) {
    getMovieUseCase.execute(
        _GetMovieUseCaseObserver(this), GetMovieUseCaseParams(apiKey));
  }

  @override
  void dispose() {
    getMovieUseCase.dispose();
  }
}

class _GetMovieUseCaseObserver extends Observer<GetMovieUseCaseResponse> {
  final HomePresenter presenter;

  _GetMovieUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getMovieOnComplete != null);
    presenter.getMovieOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getMovieOnError != null);
    presenter.getMovieOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getMovieOnNext != null);
    presenter.getMovieOnNext(response.movie);
  }
}
