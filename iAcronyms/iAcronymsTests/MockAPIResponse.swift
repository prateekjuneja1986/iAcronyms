//
//  MockAPIResponse.swift
//  iAcronymsTests
//
//  Created by Prateek Juneja on 30/01/23.
//

import XCTest
@testable import iAcronyms

class MockAPIResponse {
    
    static func getMockUrl(searchText: String) -> URL? {
        return URL(string: APIConstants.searchApiURL + searchText)
    }
    
    static func serialiseJsonData(mockedData: [[String: Any]]) -> Data {
        var jsonData = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: mockedData, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        return jsonData
    }
    
    static func setMock(response: [[String: Any]], requestUrl: URL?, statusCode: Int) {
        let serialisedData = serialiseJsonData(mockedData: response)
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == requestUrl else {
                return (HTTPURLResponse(), Data())
            }
            if let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil) {
                return (response, serialisedData)
            }
            return (HTTPURLResponse(), Data())
        }
    }
    
    static func getSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        return sessionConfiguration
    }
}
