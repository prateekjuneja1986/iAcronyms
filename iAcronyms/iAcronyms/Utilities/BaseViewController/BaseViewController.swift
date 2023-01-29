//
//  BaseViewController.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 04/01/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    // Variables
    var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Activity Indicator Methods
    func startIndicatorAnimating() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 40,height: 40))
            activityIndicator?.center = self.view.center
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.style = .large
            view.addSubview(activityIndicator!)
        }
        activityIndicator?.startAnimating()
    }
    
    func stopIndicatorAnimating() {
        self.activityIndicator?.stopAnimating()
    }
}
