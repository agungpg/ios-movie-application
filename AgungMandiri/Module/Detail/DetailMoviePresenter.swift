

import Foundation

import Foundation

class DetailMoviePresenter: DetailMoviePresentation {
    var router: DetailMovieWireFrame?
    var view: DetailMovieView?
    var interactor: DetailMovieUseCae?
    
    func getDetailMovie(movieId: Int) {
        view?.showLoading()
        interactor?.requestDetailMovie(movieId: movieId)
    }
    
    func getReviews(movieId: Int) {
        interactor?.requestReviews(movieId: movieId)
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutput {
    func responseReviews(data: ReviewResponse) {
        view?.successGetReviews(data: data)
    }
    
    func responseDetailMovie(data: DetailMovieResponse) {
        view?.hideLoading()
        view?.successGetDetailMovie(data: data)
    }
    
    func dataFailed(message: String) {
        view?.showError(title: "Error", message: message)
    }
    
    
}
