
import Foundation

struct ReviewResponse: Codable {
    let results: [Review]
}

struct Review: Codable {
    let author: String
    let content: String
}
