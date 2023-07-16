
import Foundation

struct DetailMovieResponse: Codable {
    let backdrop_path: String
    let genres: [Genre]
    let title: String
    let release_date: String
    let vote_average: Float
    let overview: String
}
