
import UIKit

class DetailMovieRouter: DetailMovieWireFrame {
    var viewController: UIViewController?

    class func createModule(movieId: Int) -> DetailMovieViewController {
        let view = DetailMovieViewController()
        let presenter: DetailMoviePresenter & DetailMovieInteractorOutput = DetailMoviePresenter()
        let interactor: DetailMovieUseCae = DetailMovieInteractor()
        let router: DetailMovieWireFrame = DetailMovieRouter()
        
        view.presenter = presenter
        view.movieId = movieId
        presenter.view = view
        presenter.router = router
        router.viewController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
