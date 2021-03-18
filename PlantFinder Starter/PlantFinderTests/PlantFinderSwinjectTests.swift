////
////  PlantFinderTests.swift
////  PlantFinderTests
////
////  Created by Fadhil Hanri on 12/03/21.
////
//
//import XCTest
//import Foundation
//import Swinject
//
//@testable import PlantFinder
//
//class PlantFinderSwinjectVCTests: XCTestCase {
//
//    private let container = Container()
//
//    fileprivate var sut: PlantFinderViewController!
//    fileprivate var interactorSpy = PlantFinderInteractorSpy()
//    fileprivate var presenterSpy = PlantFinderPresenterSpy()
//    fileprivate var routerSpy = PlantFinderRouterSpy()
//    fileprivate var workerSpy = PlantFinderWorkerSpy()
//
//    override func setUp() {
//        super.setUp()
//        AppInjector.container = self.container
//
//        sut = AppInjector.shared.resolve(PlantFinderViewController.self) ?? PlantFinderViewController()
//        interactorSpy.worker = AppInjector.shared.resolve(PlantFinderWorkerDelegate.self) ?? workerSpy
//        interactorSpy.ouput = AppInjector.shared.resolve(PlantFinderInteractorOutput.self) ?? presenterSpy
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        container.removeAll()
//    }
//
//    // MARK: - Tests
//    // 1. Make URL request
//    func test_should_be_able_to_request_plant_list() {
//        sut.interactor = interactorSpy
//        sut.interactor.requestPlantList(with: "rose")
//        XCTAssertTrue(interactorSpy.requestPlantListIsCalled)
//    }
//
//    // 2. Make networking request
//    func test_should_make_networking_request() {
//        sut.interactor = interactorSpy
//        sut.interactor.requestPlantList(with: "rose")
//        XCTAssertTrue(workerSpy.getPlantListResult.isCalled)
//    }
//
//    // 3. Check for errors
//    func test_should_be_able_to_check_error() {
//        interactorSpy.isError = true
//        sut.interactor = interactorSpy
//        sut.interactor.requestPlantList(with: "rose")
//        XCTAssertTrue(presenterSpy.presentErrorIsCalled)
//    }
//
//    func test_should_be_able_to_present_error() {
//        sut.router = routerSpy
//        sut.router.presentAlert(with: "Error")
//
//        let result = routerSpy.presentAlertResult
//        XCTAssertTrue(result.isCalled)
//        XCTAssertEqual("Error", result.message)
//    }
//
//    // 4. Parse the returned information
//    func test_should_be_able_to_parse_data() {
//        sut.interactor = interactorSpy
//        sut.interactor.requestPlantList(with: "rose")
//
//        let data = workerSpy.getPlantListResult.data
//        sut.interactor.ouput.parsingPlantListData(with: data)
//
//        let responseData = presenterSpy.parsingPlantListDataResult.response as! [Plant.Response.Data]
//        XCTAssertEqual("testplant", responseData.first?.scientific_name)
//    }
//
//    // 5. Update the UI with plant list
//    func test_should_be_able_to_update_plant_list_data() {
//        let inititalList = sut.plantList.count
//        sut.interactor = interactorSpy
//        sut.interactor.requestPlantList(with: "rose")
//
//        let data = workerSpy.getPlantListResult.data
//        sut.interactor.ouput.parsingPlantListData(with: data)
//
//        let updatedList = presenterSpy.parsingPlantListDataResult.response as! [Plant.Response.Data]
//        XCTAssertTrue(inititalList < updatedList.count)
//    }
//}
//
//fileprivate enum TestError: Error {
//    case expectedError
//}
//
//fileprivate func throwError() -> TestError {
//    return .expectedError
//}
//
//fileprivate class PlantFinderInteractorSpy: PlantFinderInteractorInput {
//    var ouput: PlantFinderInteractorOutput!
//    var worker: PlantFinderWorkerDelegate!
//
//    var requestPlantListIsCalled = false
//    var isError = false
//    func requestPlantList(with keyword: String) {
//        requestPlantListIsCalled = true
//
//        let urlRequest = URLRequest(url: URL(string: "https://trefle.io/")!)
//        let expectation = XCTestExpectation(description: "Mock request")
//        worker.getPlantList(request: urlRequest) { (_, _) in
//            expectation.fulfill()
//        }
//
//        if self.isError {
//            self.ouput.presentError(with: throwError())
//        }
//    }
//}
//
//fileprivate class PlantFinderPresenterSpy: PlantFinderInteractorOutput {
//    var output: PlantFinderPresenterOutput!
//
//    var presentErrorIsCalled = false
//    func presentError(with error: Error) {
//        presentErrorIsCalled = true
//    }
//
//    var parsingPlantListDataResult = (isCalled: false, response: [])
//    func parsingPlantListData(with data: Data) {
//        let decoder = JSONDecoder()
//
//        if let response = try? decoder.decode(Plant.Response.self, from: data) {
//            if !response.data.isEmpty {
//                parsingPlantListDataResult = (true, response.data)
//            } else {
//                parsingPlantListDataResult = (true, [])
//            }
//
//        } else {
//            parsingPlantListDataResult = (true, [])
//        }
//    }
//}
//
//fileprivate class PlantFinderRouterSpy: PlantFinderRouterDelegate {
//    var presentAlertResult = (isCalled: false, message: "")
//    func presentAlert(with message: String) {
//        presentAlertResult = (true, message)
//    }
//}
//
//fileprivate class PlantFinderWorkerSpy: PlantFinderWorkerDelegate {
//    var getPlantListResult = (isCalled: false, data: Data())
//    func getPlantList(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
//        let data = readJSON(name: "dataset")!
//        getPlantListResult = (true, data)
//    }
//
//    private func readJSON(name: String) -> Data? {
//        let bundle = Bundle(for: PlantFinderSwinjectVCTests.self)
//        guard let url = bundle.url(forResource: name, withExtension: "json") else { return nil }
//
//        do {
//            return try Data(contentsOf: url, options: .mappedIfSafe)
//        }
//        catch {
//            XCTFail("Error occurred parsing test data")
//            return nil
//        }
//    }
//}
