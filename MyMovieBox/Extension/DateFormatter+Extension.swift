//
//  DateFormatter+Extension.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import Foundation

extension DateFormatter {
    static let profileDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy.MM.dd 가입"
        return formatter
    }()

}
