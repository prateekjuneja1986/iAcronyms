//
//  NavigationLocator.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 27/01/23.
//

import Foundation
import UIKit

enum NavigationLocator {
    case searchList
    
    func getStoryboardWithName(appStoryboard: AppStoryboards) -> UIStoryboard {
        return UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
    }
    
    func getNavigationController() -> UIViewController {
        let storyBoard = self.getStoryboardWithName(appStoryboard: .main)
        switch self {
        case .searchList:
            let searchAcronymsListViewController = SearchAcronymsListViewController.instantiate(storyboard: storyBoard)
            as! SearchAcronymsListViewController
            searchAcronymsListViewController.viewModel = SearchAcronymsViewModel(searchAPIService: SearchAPIService())
            return searchAcronymsListViewController
        }
    }
}
