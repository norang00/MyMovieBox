//
//  NetworkManager.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    final func callRequest<T: Decodable>(_ api: TMDBRequest,
                                         _ type: T.Type,
                                         successHandler: @escaping (T) -> Void,
                                         failureHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print("success")
                    successHandler(value)
                case .failure(let error):
                    print("failure", error)
                    var errorMessage: String = ""
                    if let urlError = error.asAFError?.underlyingError as? URLError {
                        errorMessage = self.getErrorMessage(urlError)
                    } else if let statusCode = error.responseCode {
                        errorMessage = self.getErrorMessage(statusCode)
                    }
                    failureHandler(errorMessage)
                }
            }
    }
        
    private func getErrorMessage(_ statusCode: Int) -> String {
        switch statusCode {
        case 400:
            return "잘못된 요청입니다. 검색어를 확인해보세요."
        case 401:
            return "권한이 없습니다. 인증키를 확인해보세요."
        case 403:
            return "이 작업에 대한 권한이 없습니다."
        case 404:
            return "존재하지 않는 검색 API 입니다. 관리자에게 문의하세요."
        case 500, 503:
            return "서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
        default:
            return "오류가 발생했습니다. 상태 코드: \(statusCode)"
        }
    }
    
    private func getErrorMessage(_ urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return "인터넷 연결이 없습니다."
        case .timedOut:
            return "서버 요청이 시간 초과되었습니다."
        default:
            return "다른 네트워크 오류: \(urlError.localizedDescription)"
        }
    }
}
