//
//  MainCordinator.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func setUpInitialNavigation() -> UINavigationController
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    func setUpInitialNavigation() -> UINavigationController {
        let searchAcronymsListViewController = NavigationLocator.searchList.getNavigationController() as! SearchAcronymsListViewController
        navigationController = UINavigationController(rootViewController: searchAcronymsListViewController)
        return navigationController!
    }


}
