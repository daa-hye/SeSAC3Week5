//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by 박다혜 on 2023/08/17.
//

import Foundation

struct Recommendation: Codable {
    let totalPages, totalResults, page: Int
    let results: [RecommendResult]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}

// MARK: - Result
struct RecommendResult: Codable {
    let originalLanguage: String
    let title, originalTitle: String
    let voteAverage: Double
    let posterPath: String?
    let id: Int
    let video: Bool
    let mediaType: MediaType
    let voteCount: Int
    let overview: String
    let backdropPath: String?
    let popularity: Double
    let adult: Bool
    let releaseDate: String
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case title
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case id, video
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case overview
        case backdropPath = "backdrop_path"
        case popularity, adult
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}
