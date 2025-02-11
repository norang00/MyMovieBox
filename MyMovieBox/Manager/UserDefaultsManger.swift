//
//  UserDefaultsManger.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum User {
    @UserDefault(key: "nickname", defaultValue: "")
    static var nickname: String
    
    @UserDefault(key: "signUpDate", defaultValue: "")
    static var signUpDate: String
    
    @UserDefault(key: "profileImageName", defaultValue: "")
    static var profileImageName: String
    
    @UserDefault(key: "likedMovies", defaultValue: [])
    static var likedMovies: [Int]
    
    @UserDefault(key: "recentSearch", defaultValue: [])
    static var recentSearch: [String]
    
    static var movieBoxLabel: String {
        return "\(likedMovies.count)개의 무비박스 보관 중"
    }
    
    static func checkLike(_ movieId: Int) -> Bool {
        if likedMovies.contains(movieId) {
            return true
        }
        return false
    }
    
    static func toggleLike(_ movieID: Int) {
        if let index = User.likedMovies.firstIndex(of: movieID) {
            User.likedMovies.remove(at: index)
        } else {
            User.likedMovies.append(movieID)
        }
    }

    static func reset() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
