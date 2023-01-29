//
//  UITableViewCell.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 28/01/23.
//

import UIKit

extension UITableViewCell {
    func updateLabelStyle() {
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
    }
}
