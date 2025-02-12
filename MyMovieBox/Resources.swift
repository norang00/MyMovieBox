//
//  Resources.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/1/25.
//

import Foundation

enum Resources {
    enum ImageName: String {
        // Custom Image
        case onboarding = "onboarding"
        
        // System Image
        case camera = "camera.fill"
        case search = "magnifyingglass"
        case chevronRight = "chevron.right"
        case cancel = "xmark"
        case popcorn = "popcorn"
        case person = "person.crop.circle"
        case like = "heart.fill"
        case unlike = "heart"
        case calendar = "calendar"
        case star = "star.fill"
        case film = "film.fill"
        case fileCircle = "film.circle.fill"
        case filmStack = "film.stack"
    }
    
    enum Title: String {
        // Tab title
        case firstTab = "CINEMA"
        case secondTab = "UPCOMING"
        case thirdTab = "PROFILE"
        
        // Navigation title
        case mainNav = "My Movie Box"
        case profileSetNav = "프로필 설정"
        case profileEditNav = "프로필 편집"
        case imageSetNav = "프로필 이미지 설정"
        case imageEditNav = "프로필 이미지 편집"
        case searchNav = "영화 검색"
        
        case start = "시작하기"
        case save = "저장"
        case deleteAll = "전체 삭제"
        case confirm = "완료"
        case check = "확인"
        case setting = "설정"
        case cancel = "취소"
        
        case onboarding = "Onboarding"
        case welcome = "당신만의 영화 상자,\nMyMovieBox를 시작해보세요"
        case likedMovie = "개의 무비박스 보관중"
        case recentSearch = "최근검색어"
        case noRecentSearch = "최근 검색어 내역이 없습니다"
        case synopsis = "Synopsis"
        case cast = "Cast"
        case poster = "Poster"
        case more = "More"
        case hide = "Hide"
        case trending = "오늘의 영화"
        case searchPlaceholder = "영화를 검색해보세요"
        case nicknamePlaceholder = "닉네임을 입력해보세요"
    }
    
    enum Alert {
        enum Title: String {
            case quit = "탈퇴하기"
            case noResult = "검색 결과가 없습니다"
            case warning = "이런! 문제가 발생했어요"
        }
        
        enum Message: String {
            case quit = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
            case noResult = "다른 검색어를 입력해보세요"
            case warning = "관리자에게 문의하세요"
        }
    }

    enum SettingTitles: String, CaseIterable {
        case frequentAsk = "자주 묻는 질문"
        case inquiry = "1:1 문의"
        case notificationSetting = "알림 설정"
        case quit = "탈퇴하기"
    }
}
