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
    //    case search
    //    case image
    //    case credit
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL+"trending/movie/day?language=ko-KR&page=1")!
        }
    }
    var method: HTTPMethod {
        switch self {
        case .trending:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer \(APIkey.tmdbKey)"]
    }
    
    var parameters: Parameters {
        switch self {
        case .trending:
            return [:] // 별도 전달 파라미터 없음
        }
    }
    
}

