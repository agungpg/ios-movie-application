

import Foundation
import Alamofire

private let BASE_URL = "https://api.themoviedb.org/"
private let URL_MOVIE = "3/movie/top_rated/"
private let URL_GENRE = "3/genre/movie/list"
private let URL_MOVIE_GENRE = "3/discover/movie"
private let URL_DETAIL_MOVIE = "3/movie/"
private let API_KEY = "27f7494f349b2950f4a6c3539034f6b7"

enum ServiceConfig {
    case movies
    case genres
    case moviesByGenre(genreId: Int)
    case detailMovie(movieId: Int)
    case reviews(movieId: Int)
}

extension ServiceConfig: URLRequestConvertible {
    var baseURL: String {
        let url = BASE_URL
        return url
    }
    
    var path: String {
        switch self {
        case .movies:
            return URL_MOVIE
            
        case .genres:
            return URL_GENRE
            
        case .moviesByGenre:
            return URL_MOVIE_GENRE
            
        case .detailMovie, .reviews:
            return URL_DETAIL_MOVIE
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .movies, .genres, .moviesByGenre, .detailMovie, .reviews:
            return .get
        }
    }
    
    func createURLEncoding(url: URL, param: [String: Any] = [:]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(30)
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
            urlRequest.allHTTPHeaderFields = getHeader(isAuthorization: true)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    func createJSONEncoding(url: URL, param: [String: Any]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(30)
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: param)
            urlRequest.allHTTPHeaderFields = getHeader(isAuthorization: true)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    //MARK : GET HEADER
    func getHeader(isAuthorization: Bool) -> [String:String] {
        let headers: [String:String] = ["Authorization": API_KEY]
        return headers
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        switch self {
            
        case .movies:
            let link = "\(baseURL)\(path)"
            let url = URL(string: link)!
            let param: [String:Any] = [
                "api_key" : API_KEY,
                "language" : "language=en-US"
            ]
            let urlRequest = createURLEncoding(url: url, param: param)
            return urlRequest
            
        case .genres:
            let link = "\(baseURL)\(path)"
            let url = URL(string: link)!
            let param: [String:Any] = [
                "api_key" : API_KEY,
                "language" : "language=en-US"
            ]
            let urlRequest = createURLEncoding(url: url, param: param)
            return urlRequest
            
        case .moviesByGenre(let genreId):
            let link = "\(baseURL)\(path)"
            let url = URL(string: link)!
            let param: [String:Any] = [
                "api_key" : API_KEY,
                "language" : "language=en-US",
                "with_genres" : genreId
            ]
            let urlRequest = createURLEncoding(url: url, param: param)
            return urlRequest
            
        case .detailMovie(let movieId):
            let link = "\(baseURL)\(path)\(movieId)"
            let url = URL(string: link)!
            let param: [String:Any] = [
                "api_key" : API_KEY,
                "language" : "language=en-US"
            ]
            let urlRequest = createURLEncoding(url: url, param: param)
            return urlRequest
            
        case .reviews(let movieId):
            let link = "\(baseURL)\(path)\(movieId)\("/reviews")"
            let url = URL(string: link)!
            let param: [String:Any] = [
                "api_key" : API_KEY,
                "language" : "language=en-US"
            ]
            let urlRequest = createURLEncoding(url: url, param: param)
            return urlRequest
        }
    }
}
