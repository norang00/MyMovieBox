//
//  TrendingViewModel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/11/25.
//

import Foundation

final class TrendingViewModel: BaseViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        
    }
    
    struct Output {
        let trendingList: Observable<[Movie]> = Observable([])
    }
    
     var trendingList: [Movie] = []
    private let dispatchGroup = DispatchGroup()
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        print(#file, #function)
    }
}
