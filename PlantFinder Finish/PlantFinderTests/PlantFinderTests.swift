//
//  PlantFinderTests.swift
//  PlantFinderTests
//
//  Created by Fadhil Hanri on 12/03/21.
//

import XCTest
import Swinject

@testable import PlantFinder

class PlantFinderViewControllerTests: XCTestCase {
    
    fileprivate var sut: PlantFinderViewController!
    
    override func setUp() {
        super.setUp()
        sut = PlantFinderViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func test_should_be_able_to_request_plant_list() {
        sut.requestPlantList()
        // ???
        // XCTAssertTrue()
    }
}
