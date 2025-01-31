//
//  TMDBRequest.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trending
    case search(query: String, page: Int)
    case image(query: Int)
    case credit(query: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    static var imageBaseURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL+"/trending/movie/day?language=ko-KR&page=1")!
        case .search:
            return URL(string: baseURL+"/search/movie")!
        case .image(let query):
            return URL(string: baseURL+"/movie/\(query)/images")!
        case .credit(let query):
            return URL(string: baseURL+"/movie/\(query)/credits")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer \(APIkey.tmdbKey)"]
    }
    
    var parameters: Parameters {
        switch self {
        case .trending:
            return [:]
        case .search(let query, let page):
            return ["query": query,
                    "include_adult": false,
                    "language": "ko-KR",
                    "page": page]
        case .image:
            return [:]
        case .credit:
            return ["language": "ko-KR"]
        }
    }
}

