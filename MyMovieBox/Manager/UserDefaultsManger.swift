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
    
    static func reset() {
        nickname = ""
        signUpDate = ""
        profileImageName = ""
        likedMovies = []
        recentSearch = []
    }
}
