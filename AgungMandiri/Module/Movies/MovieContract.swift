

import UIKit
import Foundation

protocol MovieView: MovieViewController {
    func successGetMovies(data: [Movie]?)
    func successGetGenres(data: [Genre]?)
    func showLoading()
    func hideLoading()
    func showError(title: String, message: String)
}

protocol MoviePresentation: class {
    var view: MovieView? { get set }
    var interactor: MovieUseCase? { get set }
    var router: MovieWireFrame? { get set }
    
    func toGenreVC(genre: Genre)
    func toDetailMovie(movieId: Int)
    func getMovies()
    func getGenres()
}

protocol MovieUseCase: class {
    var output: MovieInteractorOutput? { get set }
    
    func requestMovies()
    func requestGenres()
}

protocol MovieInteractorOutput: class {
    func dataFailed(message: String)
    func responseMovie(data: [Movie])
    func responseGenre(data: [Genre])
}

protocol MovieWireFrame: class {
    var viewController: UIViewController? { get set }
    
    static func createModule() -> MovieViewController
    func toGenreModule(genre: Genre)
    func toDetailMovie(movieId: Int)
}
