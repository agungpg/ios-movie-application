

import UIKit
import Foundation

protocol GenreView: GenreViewController {
    func successGetMoviesByGenre(data: [Movie]?)
    func showLoading()
    func hideLoading()
    func showError(title: String, message: String)
}

protocol GenrePesentation: class {
    var view: GenreView? { get set }
    var interactor: GenreUseCase? { get set }
    var router: GenreWireFrame? { get set }
    
    func getMoviesByGenre(genreId: Int)
    func toDetailMovie(movieId: Int)
}

protocol GenreUseCase: class {
    var output: GenreInteractorOutput? { get set }
    
    func requestMoviesByGenre(genreId: Int)
}

protocol GenreInteractorOutput: class {
    func dataFailed(message: String)
    func responseMovieByGenre(data: [Movie])
}

protocol GenreWireFrame: class {
    var viewController: UIViewController? { get set }
    
    static func createModule(genre: Genre) -> GenreViewController
    func toDetailMovie(movieId: Int)
}
