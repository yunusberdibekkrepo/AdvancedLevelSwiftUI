//
//  NewMockDataService_Tests.swift
//  AdvancedSwiftUI_Tests
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

@testable import AdvancedSwiftUI
import Combine
import XCTest

final class NewMockDataService_Tests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items1: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [randomString(), randomString()]

        // When
        let dataService1 = NewMockDataService(items: items1)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)

        // Then
        XCTAssertFalse(dataService1.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }

    func test_NewMockDataService_downloadsItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)

        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "")

        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }

    func test_NewMockDataService_downloadsItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)

        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "")

        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }

    func test_NewMockDataService_downloadsItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMockDataService(items: [])

        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "It does throw an error")
        let expectation2 = XCTestExpectation(description: "It does throw URLError.badServerResponse")

        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError ==  URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
