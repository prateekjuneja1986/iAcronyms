//
//  SearchAcronymsViewModelTests.swift
//  iAcronymsTests
//
//  Created by Prateek Juneja on 30/01/23.
//

import XCTest
@testable import iAcronyms

final class SearchAcronymsViewModelTests: XCTestCase {
    
    var sut: SearchAcronymsViewModel!
    var urlSession: URLSession = URLSession.init(configuration: .default)
    
    override func setUpWithError() throws {
        urlSession = URLSession.init(configuration: MockAPIResponse.getSessionConfiguration())
        sut = SearchAcronymsViewModel()
        NetworkManager.urlSession = urlSession
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSearchAcronymsApiSuccess() async {
        let searchItem = "Name"
        let mockedData = TestJsonReaderHelper.readJSONFrom(fileName: "MockAcronyms") as? [[String: Any]] ?? [[:]]
        MockAPIResponse.setMock(response: mockedData,
                                requestUrl: MockAPIResponse.getMockUrl(searchText: searchItem),
                                statusCode: HttpStatusCode.success.rawValue)
        do {
            try await sut.searchAcronymsForSearchText(searchText: searchItem)
            XCTAssertEqual(sut.acronyms.count, 2)
        } catch {
            XCTFail("Unable to load the acronym list")
        }
    }
    
    func testSearchAcronymsApiFailure() async {
        let searchItem = ""
        MockAPIResponse.setMock(response: [[:]],
                                requestUrl: MockAPIResponse.getMockUrl(searchText: searchItem),
                                statusCode: HttpStatusCode.badRequest.rawValue)
        do {
            try await sut.searchAcronymsForSearchText(searchText: searchItem)
            XCTAssertEqual(sut.acronyms.count, 0)
        } catch {
            XCTFail("Unable to load the acronym list")
            
        }
    }
    
}
