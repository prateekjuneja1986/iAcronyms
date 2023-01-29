//
//  SearchAPIService.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation

protocol SearchAPIProtocol {
    func getAllAcronyms(searchText: String) async throws -> [AcronymDetails]?
}

final class SearchAPIService: SearchAPIProtocol {
    private let networkManager: NetworkRequestProtocol
    
    init(networkManager: NetworkRequestProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAllAcronyms(searchText: String) async throws -> [AcronymDetails]? {
        guard let apiURL = URL(string: APIConstants.searchApiURL + searchText) else {
            throw APIError.badRequest
        }
        let urlRequest = URLRequest(url: apiURL)
        let apiData = try await networkManager.get(request: urlRequest)
        switch apiData {
        case .success(let data):
            do {
                guard let acronyms = try? JSONDecoder().decode([Acronym].self, from: data) else {
                    throw APIError.dataError
                }
                if acronyms.count > 0 {
                    return acronyms.first?.lfs
                } else {
                    return []
                }
            } catch {
                throw APIError.dataError
            }
        case .failure(let error):
            throw error
        }
    }
}
