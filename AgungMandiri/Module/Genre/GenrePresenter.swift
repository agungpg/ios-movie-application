

import Foundation

class GenrePresenter: GenrePesentation {
    var router: GenreWireFrame?
    var view: GenreView?
    var interactor: GenreUseCase?
    
    func getMoviesByGenre(genreId: Int) {
        view?.showLoading()
        interactor?.requestMoviesByGenre(genreId: genreId)
    }
    
    func toDetailMovie(movieId: Int) {
        router?.toDetailMovie(movieId: movieId)
    }
    
    
}

extension GenrePresenter: GenreInteractorOutput {
    func responseMovieByGenre(data: [Movie]) {
        view?.hideLoading()
        view?.successGetMoviesByGenre(data: data)
    }
    
    func dataFailed(message: String) {
        view?.showError(title: "Error", message: message)
    }
    
    
}

