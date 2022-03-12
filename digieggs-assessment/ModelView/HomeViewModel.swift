//
//  HomeViewModeş.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import Foundation

protocol IHomeViewModel {
    func fetch(page: Int, characterName: String)
    var homeViewDelegate: IHomeViewModelDelegate? {get set}
}

protocol IHomeViewModelDelegate {
    func setRickAndMortyDatas(data: CharacterData)
    func isFinish(finished: Bool)
}

final class HomeViewModel: IHomeViewModel {
    var homeViewDelegate: IHomeViewModelDelegate?
    var isLoading: Bool = false
    
    
    func fetch(page: Int, characterName: String) {
        Network.shared.apollo.fetch(query: AllCharacterQuery(page: page, name: characterName)) { result in
            switch result {
                case .success(let response):
                    if let characters = response.data?.characters {
                        self.homeViewDelegate?.setRickAndMortyDatas(data: characters)
                    } else {
                        self.homeViewDelegate?.isFinish(finished: true)
                    }
                case .failure(let error):
                    print("Network Error: \(error)")
            }
        }
    }
}
