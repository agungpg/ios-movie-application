
import UIKit

class MovieRouter: MovieWireFrame {
    func toGenreModule(genre: Genre) {
        let vc = GenreRouter.createModule(genre: genre)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func toDetailMovie(movieId: Int) {
        let vc = DetailMovieRouter.createModule(movieId: movieId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    var viewController: UIViewController?

    class func createModule() -> MovieViewController {
        let view = MovieViewController()
        let presenter: MoviePresentation & MovieInteractorOutput = MoviePresenter()
        let interactor: MovieUseCase = MovieIntector()
        let router: MovieWireFrame = MovieRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
