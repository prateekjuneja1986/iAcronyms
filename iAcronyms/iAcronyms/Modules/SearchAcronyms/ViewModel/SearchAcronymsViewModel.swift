//
//  SearchAcronymsViewModel.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation
import Combine
import UIKit

class SearchAcronymsViewModel {
    
    // MARK: - Properties
    //Published
    @Published private(set) var acronyms: [AcronymDetails] = []
    @Published private(set) var isDataLoading: Bool = false
    @Published private(set) var error: Error? = nil
    
    // MARK: - Properties
    // Variables
    private let searchAPIService: SearchAPIProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchingWorkTask: Task<Void, Never>?
    
    // MARK: - Custom Initializer
    init(searchAPIService: SearchAPIProtocol = SearchAPIService()) {
        self.searchAPIService = searchAPIService
    }
    
    // MARK: - View Model Helper Methods
    func getAcronymsCount() -> Int {
        return acronyms.count
    }
    
    func getAcronyms(for indexPath: IndexPath) -> AcronymDetails? {
        guard indexPath.section == 0, indexPath.row >= 0, acronyms.count > indexPath.row else { return nil }
        return acronyms[indexPath.row]
    }
    
    
    func searchAcronyms(searchText: String) async throws {
        if searchText.isEmpty {
            stopSearchingIfTextIsEmpty()
            return
        }
        
        if searchingWorkTask != nil {
            try await Task.sleep(seconds: 0.1)
            searchingWorkTask?.cancel()
        }
        
        searchingWorkTask = Task.init {
            do {
                try await searchAcronymsForSearchText(searchText: searchText)
            } catch let error {
                print("Task Error description - \(error.localizedDescription)")
            }
        }
    }
    
    func searchAcronymsForSearchText(searchText: String) async throws {
        do {
            self.isDataLoading = true
            print("isDataLoading-\(self.isDataLoading)")
            let searchResponse = try await searchAPIService.getAllAcronyms(searchText: searchText)
            self.acronyms = searchResponse ?? []
            print("Response - \(self.acronyms.count)")
            self.isDataLoading = false
        } catch let error {
            if error._code != NSURLErrorCancelled {
                print("Error description - \(error.localizedDescription)")
                self.acronyms = []
                self.error = error
                self.isDataLoading = false
            }
            print("Error in Data Loading-\(self.isDataLoading)")
        }

    }
    
    private func stopSearchingIfTextIsEmpty() {
        searchingWorkTask?.cancel()
        self.acronyms = []
        print("stopSearchingIfTextIsEmpty\(self.isDataLoading)")
        self.isDataLoading = false
    }
}
