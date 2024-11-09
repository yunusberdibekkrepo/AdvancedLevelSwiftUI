//
//  UnitTestingBootcampViewModel.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import Combine
import Foundation
import SwiftUI

final class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    var cancellables = Set<AnyCancellable>()

    let dataService: NewDataServiceProtocol

    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }

    func addItem(item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }

    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }

    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here: \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }

    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }

    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in

            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)
    }

    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}
