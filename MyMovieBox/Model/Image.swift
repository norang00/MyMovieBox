//
//  Image.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import Foundation

struct Image: Decodable {
    let id: Int
    let backdrops: [Backdrop]
    let posters: [Poster]
}

struct Backdrop: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

struct Poster: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

