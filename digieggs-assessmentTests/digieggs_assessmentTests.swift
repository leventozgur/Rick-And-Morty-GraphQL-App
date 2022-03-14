//
//  digieggs_assessmentTests.swift
//  digieggs-assessmentTests
//
//  Created by Levent ÖZGÜR on 12.03.22.
//

import XCTest
@testable import digieggs_assessment

class digieggs_assessmentTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Fetch All Characters with Expected parameters
    func testFetchCharactersWithExpectedValues() {
        let homeViewModel: IHomeViewModel = HomeViewModel()
        let expectation = XCTestExpectation(description: #function)
        homeViewModel.network.getAllCharacters(page: 1, characterName: "") { result in
            expectation.fulfill()
            switch result {
            case .success(let response):
                if let characters = response.data?.characters {
                    XCTAssertTrue(characters.results!.count > 0, "characters array is empty")
                }
            case .failure(let error):
                XCTFail("Unexpected error: \(error).")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    //MARK: - Fetch All Rick Characters with Expected parameters
    func testFetchRickCharactersWithExpectedValues() {
        let homeViewModel: IHomeViewModel = HomeViewModel()
        let expectation = XCTestExpectation(description: #function)
        homeViewModel.network.getAllCharacters(page: 1, characterName: FilterValuesEnum.rick.rawValue) { result in
            expectation.fulfill()
            switch result {
            case .success(let response):
                if let characters = response.data?.characters {
                    XCTAssertTrue(characters.results!.count > 0, "Rick characters array is empty")
                }
            case .failure(let error):
                XCTFail("Unexpected error: \(error).")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    //MARK: - Fetch All Morty Characters with Expected parameters
    func testFetchMortyCharactersWithExpectedValues() {
        let homeViewModel: IHomeViewModel = HomeViewModel()
        let expectation = XCTestExpectation(description: #function)
        homeViewModel.network.getAllCharacters(page: 1, characterName: FilterValuesEnum.morty.rawValue) { result in
            expectation.fulfill()
            switch result {
            case .success(let response):
                if let characters = response.data?.characters {
                    XCTAssertTrue(characters.results!.count > 0, "Morty characters array is empty")
                }
            case .failure(let error):
                XCTFail("Unexpected error: \(error).")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    //MARK: - Fetch Characters with Unexpected page parameter
    func testFetchCharactersWithUnexpectedPageValue() {
        let homeViewModel: IHomeViewModel = HomeViewModel()
        let expectation = XCTestExpectation(description: #function)
        homeViewModel.network.getAllCharacters(page: 9999, characterName: FilterValuesEnum.morty.rawValue) { result in
            expectation.fulfill()
            switch result {
            case .success(let response):
                XCTAssertNil(response.data?.characters)
            case .failure(let error):
                XCTFail("Unexpected error: \(error).")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    //MARK: - Fetch Characters with Unexpected character parameter
    func testFetchCharactersWithUnexpectedCharacterValue() {
        let homeViewModel: IHomeViewModel = HomeViewModel()
        let expectation = XCTestExpectation(description: #function)
        homeViewModel.network.getAllCharacters(page: 1, characterName: "FilterValuesEnum.morty.rawValue") { result in
            expectation.fulfill()
            switch result {
            case .success(let response):
                XCTAssertNil(response.data?.characters)
            case .failure(let error):
                XCTFail("Unexpected error: \(error).")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

// IHomeViewModelDelegate Definations
extension digieggs_assessmentTests: IHomeViewModelDelegate {


    func setRickAndMortyDatas(data: CharacterData) {
        print(data)
    }

    func isFinish(finished: Bool) {
        print(finished)
    }
}
