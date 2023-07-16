
import UIKit

class GenreRouter: GenreWireFrame {
    var viewController: UIViewController?

    class func createModule(genre: Genre) -> GenreViewController {
        let view = GenreViewController()
        let presenter: GenrePresenter & GenreInteractorOutput = GenrePresenter()
        let interactor: GenreUseCase = GenreInteractor()
        let router: GenreWireFrame = GenreRouter()
        
        view.presenter = presenter
        view.genre = genre
        presenter.view = view
        presenter.router = router
        router.viewController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
    
    func toDetailMovie(movieId: Int) {
        let vc = DetailMovieRouter.createModule(movieId: movieId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
