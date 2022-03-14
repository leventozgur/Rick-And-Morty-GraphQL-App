//
//  Network.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import Foundation
import Apollo

protocol INetwork {
    func getAllCharacters(page: Int, characterName: String, callback: @escaping (Result<GraphQLResult<AllCharacterQuery.Data>, Error>) -> Void)
}

final class Network: INetwork {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)

    func getAllCharacters(page: Int, characterName: String, callback: @escaping (Result<GraphQLResult<AllCharacterQuery.Data>, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            Network.shared.apollo.fetch(query: AllCharacterQuery(page: page, name: characterName)) { result in
                callback(result)
            }
        }
    }
}
