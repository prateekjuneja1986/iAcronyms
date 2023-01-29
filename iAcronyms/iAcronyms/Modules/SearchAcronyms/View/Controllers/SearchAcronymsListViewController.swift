//
//  SearchAcronymsListViewController.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import UIKit
import Combine

class SearchAcronymsListViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var acronymTableView: UITableView!
    
    // MARK: - Properties
    // Variables
    var viewModel: SearchAcronymsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindControls()
    }
    
    // MARK: - Setup methods
    func setUpUI() {
        acronymTableView.tableFooterView = UIView()
        searchBar.enablesReturnKeyAutomatically = true
    }
    
    // MARK: - Helper methods
    func bindControls() {
        bindDataSource()
        bindActivityIndicator()
        bindErrorHandle()
    }
    
    func bindDataSource() {
        viewModel?.$acronyms
            .receive(on: DispatchQueue.main)
            .sink { [weak self] acronyms in
                self?.acronymTableView.reloadData()
            }.store(in: &cancellables)
    }
    
    func bindActivityIndicator() {
        viewModel?.$isDataLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                if loading {
                    self?.startIndicatorAnimating()
                } else {
                    self?.stopIndicatorAnimating()
                }
            }.store(in: &cancellables)
    }
    
    func bindErrorHandle() {
        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let err = error {
                    self?.handleError(err)
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Data Source methods
    func searchAcronyms(searchText: String) {
        Task {
            try await viewModel?.searchAcronyms(searchText: searchText)
        }
    }
    
}


// MARK: - SearchBar Delegates methods
extension SearchAcronymsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchAcronyms(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let text = searchBar.text, text.count > 7 {
            return false
        }
        let invalidChars = NSCharacterSet.alphanumerics.inverted
        let newString = text.trimmingCharacters(in: invalidChars)
        if newString.count < text.count {
            return false
        } else {
            return true
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - TableView DataSource methods
extension SearchAcronymsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let acronymsCount = self.viewModel?.getAcronymsCount() else {
            return 0
        }
        return acronymsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchCell.rawValue, for: indexPath)
        cell.updateLabelStyle()
        guard let acronym = viewModel?.getAcronyms(for: indexPath) else {
            cell.textLabel?.text = ""
            return cell
        }
        cell.textLabel?.text = acronym.lf
        return cell
    }
}

