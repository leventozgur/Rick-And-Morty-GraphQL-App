//
//  HomeViewModeş.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import Foundation

protocol IHomeViewModel {
    func fetch(page: Int, characterName: String)
    var homeViewDelegate: IHomeViewModelDelegate? { get set }
    var network: INetwork { get set }
}

protocol IHomeViewModelDelegate {
    func setRickAndMortyDatas(data: CharacterData)
    func isFinish(finished: Bool)
}

final class HomeViewModel: IHomeViewModel {
    var homeViewDelegate: IHomeViewModelDelegate?
    var network: INetwork = Network()

    func fetch(page: Int, characterName: String) {
        if let homeViewDelegate = homeViewDelegate {
            self.network.getAllCharacters(page: page, characterName: characterName) { result in
                switch result {
                case .success(let response):
                    if let characters = response.data?.characters {
                        homeViewDelegate.setRickAndMortyDatas(data: characters)
                    } else {
                        homeViewDelegate.isFinish(finished: true)
                    }
                case .failure(let error):
                    homeViewDelegate.isFinish(finished: true)
                    print("Network Error: \(error)")
                }
            }
        }
    }
}
