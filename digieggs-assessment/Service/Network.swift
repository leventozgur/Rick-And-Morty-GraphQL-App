//
//  Network.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private let serviceURL = "https://rickandmortyapi.com/graphql"
  private(set) lazy var apollo = ApolloClient(url: URL(string: serviceURL)!)
}

