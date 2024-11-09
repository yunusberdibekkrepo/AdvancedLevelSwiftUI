//
//  NewMockDataService.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import Combine
import Foundation
import SwiftUI

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

final class NewMockDataService: NewDataServiceProtocol {
    let items: [String]

    init(items: [String]?) {
        self.items = items ?? [
            randomString(),
            randomString(),
            randomString(),
        ]
    }

    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }

    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}
