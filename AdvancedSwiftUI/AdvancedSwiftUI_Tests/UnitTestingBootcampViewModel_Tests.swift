//
//  UnitTestingBootcampViewModel_Tests.swift
//  AdvancedSwiftUI_Tests
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

@testable import AdvancedSwiftUI
import Combine
import XCTest

// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming structure: test_[struct or class]_[variable or function]_[expected value]

// Testing structure: Given, When, Then

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    var viewModel: UnitTestingBootcampViewModel?
    var cancellables = Set<AnyCancellable>()

    // Tüm testlerden önce çağrılır.
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    // Tüm testlerden sonra çağrılır.
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium = true

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertTrue(vm.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium = false

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertFalse(vm.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium = Bool.random()

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0 ..< 10 {
            // Given
            let userIsPremium = Bool.random()

            // When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        // Given

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount = Int.random(in: 1 ..< 100)
        for _ in 0 ..< loopCount {
            vm.addItem(item: randomString())
        }

        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        // XCAssertGreaterThanOrEqual
        // XCAssertLessThan
        // XCAssertLessThanOrEqual
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        vm.addItem(item: "")

        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }

        // When
        vm.addItem(item: "")

        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        // Given

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        // Select valid item
        let newItem = randomString()
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)

        // Select invalid item
        vm.selectItem(item: UUID().uuidString)

        // Then
        XCTAssertNil(vm.selectedItem)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let newItem = randomString()
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)

        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }

    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount = Int.random(in: 0 ..< 100)
        var itemsArray: [String] = []

        for _ in 0 ..< loopCount {
            let newItem = randomString()
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }

        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectItem(item: randomItem)

        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount = Int.random(in: 0 ..< 100)
        for _ in 0 ..< loopCount {
            vm.addItem(item: randomString())
        }

        // Then
        XCTAssertThrowsError(try vm.saveItem(item: randomString()))
        XCTAssertThrowsError(try vm.saveItem(item: randomString()), "Should throw item not found error!") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount = Int.random(in: 0 ..< 100)
        for _ in 0 ..< loopCount {
            vm.addItem(item: randomString())
        }

        // Then
        do {
            try vm.saveItem(item: "")
        } catch {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
    }

    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount = Int.random(in: 0 ..< 100)
        var itemsArray: [String] = []

        for _ in 0 ..< loopCount {
            let newItem = randomString()
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }

        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)

        // Then
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }

    func test_UnitTestingBootcampViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        vm.$dataArray
            .dropFirst() // vm içinde dataArray blank bir şekilde tanımlandığından ilk değer verildiği andaki yaplan yayını almıyoruz.
            .sink { _ in
                expectation.fulfill() // veriler geldiğinde expectation içine verilerin geldiğini haber veriyoruz.
            }
            .store(in: &cancellables)
        vm.downloadWithEscaping()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let expectation = XCTestExpectation(description: "Should return items after a second.")
        vm.$dataArray
            .dropFirst() // vm içinde dataArray blank bir şekilde tanımlandığından ilk değer verildiği andaki yaplan yayını almıyoruz.
            .sink { _ in
                expectation.fulfill() // veriler geldiğinde expectation içine verilerin geldiğini haber veriyoruz.
            }
            .store(in: &cancellables)
        vm.downloadWithCombine()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }

    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems2() {
        // Given
        let items: [String] = [
            randomString(),
            randomString(),
            randomString(),
            randomString(),
            randomString(),
            randomString()
        ]
        
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random(), dataService: dataService)

        // When
        let expectation = XCTestExpectation(description: "Should return items after a second.")
        vm.$dataArray
            .dropFirst() // vm içinde dataArray blank bir şekilde tanımlandığından ilk değer verildiği andaki yaplan yayını almıyoruz.
            .sink { _ in
                expectation.fulfill() // veriler geldiğinde expectation içine verilerin geldiğini haber veriyoruz.
            }
            .store(in: &cancellables)
        vm.downloadWithCombine()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
