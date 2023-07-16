

import Foundation

class GenreInteractor: GenreUseCase {
    
    
    var output: GenreInteractorOutput?
    private let movieApi: CoreApi
    
    init() {
        self.movieApi = CoreApi()
        movieApi.delegate = self
    }
    
    func requestMoviesByGenre(genreId: Int) {
        movieApi.getRequest(ServiceConfig.moviesByGenre(genreId: genreId))
    }
    
}

extension GenreInteractor: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let response = try jsonDecoder.decode(MoviesResponse.self, from: data)
            self.output?.responseMovieByGenre(data: response.results)
            
        } catch let error {
            print("error server \(error.localizedDescription)")
            self.output?.dataFailed(message: "Data error, \(error.localizedDescription)")
        }
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        self.output?.dataFailed(message: "Failed get data")
    }
    
    
}

