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
                                         completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    var returnError: CustomError? = nil
                    if let urlError = error.underlyingError as? URLError {
                        returnError = self.getErrorMessage(urlError)
                    } else if let statusCode = error.responseCode {
                        returnError = self.getErrorMessage(statusCode)
                    } else if error.isResponseSerializationError {
                        returnError = CustomError.parsingFailed
                    }
                    completionHandler(.failure(returnError!))
                }
            }
    }
    
    enum CustomError: String, Error {
        case statusCode400 = "잘못된 요청입니다. 검색어를 확인해보세요."
        case statusCode401 = "권한이 없습니다. 인증키를 확인해보세요."
        case statusCode403 = "이 작업에 대한 권한이 없습니다."
        case statusCode404 = "존재하지 않는 검색 API 입니다. 관리자에게 문의하세요."
        case statusCode500 = "서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
        case noInternet = "인터넷 연결이 없습니다."
        case timedOut = "서버 요청이 시간 초과되었습니다."
        case parsingFailed = "Data parsing error"
        case defaultCase = "관리자에게 문의하세요."
    }

    private func getErrorMessage(_ statusCode: Int) -> CustomError {
        switch statusCode {
        case 400:
            return CustomError.statusCode400
        case 401:
            return CustomError.statusCode401
        case 403:
            return CustomError.statusCode403
        case 404:
            return CustomError.statusCode404
        case 500:
            return CustomError.statusCode400
        default:
            return CustomError.defaultCase
        }
    }

    private func getErrorMessage(_ urlError: URLError) -> CustomError {
        switch urlError.code {
        case .notConnectedToInternet:
            return CustomError.noInternet
        case .timedOut:
            return CustomError.timedOut
        default:
            return CustomError.defaultCase
        }
    }
}
