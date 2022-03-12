//
//  Network.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import Foundation
import Apollo

protocol INetwork {
    func getAllCharacters(page: Int, characterName: String, homeViewDelegate: IHomeViewModelDelegate)
}

final class Network: INetwork {
    private let baseURL: String = "https://rickandmortyapi.com/graphql"
    private var apolloClient: ApolloClient
    
    init() {
        apolloClient = ApolloClient(url: URL(string: baseURL)!)
    }
    
    func getAllCharacters(page: Int, characterName: String, homeViewDelegate: IHomeViewModelDelegate) {
        apolloClient.fetch(query: AllCharacterQuery(page: page, name: characterName)) { result in
            switch result {
                case .success(let response):
                    if let characters = response.data?.characters {
                        homeViewDelegate.setRickAndMortyDatas(data: characters)
                    } else {
                        homeViewDelegate.isFinish(finished: true)
                    }
                case .failure(let error):
                    print("Network Error: \(error)")
            }
        }
    }
}
    

