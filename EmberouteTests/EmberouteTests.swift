//
//  EmberouteTests.swift
//  EmberouteTests
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import XCTest
import Combine
@testable import Emberoute

final class TripListViewModelImplTests: XCTestCase {
    private var viewModel: TripListViewModelImpl!
    private var mockRepository: TripListRepositoryMock!
    private var mockMapper: TripListViewDataMapperMock!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockRepository = TripListRepositoryMock()
        mockMapper = TripListViewDataMapperMock()
        viewModel = TripListViewModelImpl(repository: mockRepository, mapper: mockMapper)
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Available Trips")
    }

    func testNumberOfRows_EmptyTrips() {
        XCTAssertEqual(viewModel.numberOfRows, 0)
    }

    func testOnViewDidLoad_Success_WithTrips() {
        mockRepository.fetchTripsResult = .success(TripListResponseBody(quotes: [], minCardTransaction: 0))
        mockMapper.mapTripsReturnValue = []

        let expectation = expectation(description: "Should emit loading and finished states")
        expectation.expectedFulfillmentCount = 3

        viewModel.onStateChange.sink { state in
            expectation.fulfill()
        }.store(in: &cancellables)

        viewModel.onViewDidLoad()

        wait(for: [expectation], timeout: 1)
    }

    func testOnViewDidLoad_Failure() {
        let error = NSError(domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Test Error Message"])
        mockRepository.fetchTripsResult = .failure(error)

        let expectation = expectation(description: "Should emit loading and snackBar states")
        expectation.expectedFulfillmentCount = 2
        viewModel.onStateChange.sink { state in
            expectation.fulfill()
        }.store(in: &cancellables)

        viewModel.onViewDidLoad()

        wait(for: [expectation], timeout: 1)
    }
}
