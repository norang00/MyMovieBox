//
//  Credit.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import Foundation

struct Credit: Decodable {
    let id: String
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let character: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case profilePath = "profile_path"
    }
}
