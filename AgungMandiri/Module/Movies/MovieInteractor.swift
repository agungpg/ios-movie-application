
import Foundation

class MovieIntector: MovieUseCase {
    
    
    var output: MovieInteractorOutput?
    private let movieApi: CoreApi
    private let genreApi: CoreApi
    
    init() {
        self.movieApi = CoreApi()
        self.genreApi = CoreApi()
        
        movieApi.delegate = self
        genreApi.delegate = self
    }
    
    func requestMovies() {
        movieApi.getRequest(ServiceConfig.movies)
    }
    
    func requestGenres() {
        genreApi.getRequest(ServiceConfig.genres)
    }
    
}

extension MovieIntector: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            switch interFace {
            case movieApi:
                let response = try jsonDecoder.decode(MoviesResponse.self, from: data)
                self.output?.responseMovie(data: response.results)
            
            case genreApi:
                let response = try JSONDecoder().decode(GenreResponse.self, from: data)
                self.output?.responseGenre(data: response.genres)
                
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
