//
//  ProfileViewModel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/11/25.
//

import Foundation

final class ProfileViewModel: BaseViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let profileCardTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let userInfo: Observable<User?> = Observable(nil)
        let presentUserSettingModal: Observable<Void?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        print(#file, #function)
        
        input.profileCardTapped.lazyBind { [weak self] _ in
            self?.output.presentUserSettingModal.value = ()
        }
    }
}
