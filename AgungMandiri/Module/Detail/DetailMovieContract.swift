

import UIKit
import Foundation

protocol DetailMovieView: DetailMovieViewController {
    func successGetDetailMovie(data: DetailMovieResponse?)
    func successGetReviews(data: ReviewResponse?)
    func showLoading()
    func hideLoading()
    func showError(title: String, message: String)
}

protocol DetailMoviePresentation: class {
    var view: DetailMovieView? { get set }
    var interactor: DetailMovieUseCae? { get set }
    var router: DetailMovieWireFrame? { get set }
    
    func getDetailMovie(movieId: Int)
    func getReviews(movieId: Int)
}

protocol DetailMovieUseCae: class {
    var output: DetailMovieInteractorOutput? { get set }
    
    func requestDetailMovie(movieId: Int)
    func requestReviews(movieId: Int)
}

protocol DetailMovieInteractorOutput: class {
    func dataFailed(message: String)
    func responseDetailMovie(data: DetailMovieResponse)
    func responseReviews(data: ReviewResponse)
}

protocol DetailMovieWireFrame: class {
    var viewController: UIViewController? { get set }
    
    static func createModule(movieId: Int) -> DetailMovieViewController
}
