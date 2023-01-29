//
//  SearchAPIResponse.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 25/01/23.
//

import Foundation

// MARK: - Search Acronym Response
struct Acronym: Codable {
    var sf: String?
    var lfs: [AcronymDetails]?
}

struct AcronymDetails: Codable {
    var lf: String?
}
