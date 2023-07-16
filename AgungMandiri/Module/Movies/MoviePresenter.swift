

import Foundation

class MoviePresenter: MoviePresentation {

    var router: MovieWireFrame?
    var view: MovieView?
    var interactor: MovieUseCase?
    
    func getMovies() {
        view?.showLoading()
        interactor?.requestMovies()
    }
    
    func getGenres() {
        view?.showLoading()
        interactor?.requestGenres()
    }
    
    func toGenreVC(genre: Genre) {
        router?.toGenreModule(genre: genre)
    }
    
    func toDetailMovie(movieId: Int) {
        router?.toDetailMovie(movieId: movieId)
    }
    
}

extension MoviePresenter: MovieInteractorOutput {
    func responseGenre(data: [Genre]) {
        view?.hideLoading()
        view?.successGetGenres(data: data)
    }
    
    func responseMovie(data: [Movie]) {
        view?.hideLoading()
        view?.successGetMovies(data: data)
    }
    
    func dataFailed(message: String) {
        view?.showError(title: "Error", message: message)
    }
    
    
}
