//
//  UIViewController.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var className: String {
        return String(describing: self)
    }
    
    class func instantiate<T: UIViewController>(storyboard: UIStoryboard) -> T? {
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    
    public func handleError(_ error: Error) {
        showAlert(errorMessage: error.localizedDescription, okTitle: AlertVariables.cancel.rawValue)
    }
    
    func showAlert(errorMessage: String, okTitle: String = AlertVariables.ok.rawValue,
                   okButtonAction: (() -> Void)? = nil) {
        
        // Create new Alert
        let alertVC = UIAlertController(title: AlertVariables.alertErrorTitle.rawValue, message: errorMessage, preferredStyle: .alert)
        // Create OK button with action handler
        let okayAction = UIAlertAction(title: okTitle, style: .default, handler: { _ in
            okButtonAction?()
        })
        alertVC.addAction(okayAction)

        // Present Alert to
        self.present(alertVC, animated: true, completion: nil)
    }
}

