//
//  NetworkManager.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation

// MARK: - API Errors
enum APIError: Error {
    case badRequest
    case serverError
    case dataError
    case unknown
    case noNetwork
    case noData
    
    var description: String {
        switch self {
        case .noNetwork:
            return "No internet, Please try again."
        default:
            return "Something went wrong, Please try again"
            
        }
    }
}

// MARK: - HTTP Response Status Codes
enum HttpStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case internalServerError = 500
}


protocol NetworkRequestProtocol {
    func get(request: URLRequest) async throws -> Result<Data, Error>
}

final class NetworkManager: NetworkRequestProtocol {
    
    lazy var reachability = Reachability()
    static var urlSession = URLSession.init(configuration: .default)
    
    func get(request: URLRequest) async throws -> Result<Data, Error> {
        if reachability?.currentReachabilityStatus == .notReachable {
            return .failure(APIError.noNetwork)
        }
        let (data, response) = try await NetworkManager.urlSession.data(for: request)
        return verifyResponse(data: data, response: response)
    }
    
    private func verifyResponse(data: Data, response: URLResponse) -> Result<Data, Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(APIError.unknown)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return .success(data)
        case 400...499:
            return .failure(APIError.badRequest)
        case 500...599:
            return .failure(APIError.serverError)
        default:
            return .failure(APIError.unknown)
        }
    }
}
