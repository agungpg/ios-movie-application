
import Foundation

class DetailMovieInteractor: DetailMovieUseCae {
    
    var output: DetailMovieInteractorOutput?
    private let movieApi: CoreApi
    private let reviewApi: CoreApi
    
    init() {
        self.movieApi = CoreApi()
        self.reviewApi = CoreApi()
        
        movieApi.delegate = self
        reviewApi.delegate = self
    }
    
    func requestDetailMovie(movieId: Int) {
        movieApi.getRequest(ServiceConfig.detailMovie(movieId: movieId))
    }
    
    func requestReviews(movieId: Int) {
        reviewApi.getRequest(ServiceConfig.reviews(movieId: movieId))
    }
    
}

extension DetailMovieInteractor: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            switch interFace {
            case movieApi:
                let response = try jsonDecoder.decode(DetailMovieResponse.self, from: data)
                self.output?.responseDetailMovie(data: response)
                
            case reviewApi:
                let response = try jsonDecoder.decode(ReviewResponse.self, from: data)
                self.output?.responseReviews(data: response)
                
            default:
                break
            }
        } catch let error {
            print("error server \(error.localizedDescription)")
            self.output?.dataFailed(message: "Data error, \(error.localizedDescription)")
        }
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        self.output?.dataFailed(message: "Failed get data")
    }
    
    
}
