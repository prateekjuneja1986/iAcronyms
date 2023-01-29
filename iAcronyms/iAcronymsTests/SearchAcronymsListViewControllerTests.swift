//
//  SearchAcronymsListViewControllerTests.swift
//  iAcronymsTests
//
//  Created by Prateek Juneja on 30/01/23.
//

import XCTest
@testable import iAcronyms

class SearchAcronymsListViewControllerTests: XCTestCase {
    
    var sut: SearchAcronymsListViewController!
    
    override func setUpWithError() throws {
        sut = (NavigationLocator.searchList.getNavigationController() as! SearchAcronymsListViewController)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testViewDidLoad_TableViewDelegateAndDataSourceShouldNotBeNil() {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.acronymTableView.delegate)
        XCTAssertNotNil(sut.acronymTableView.dataSource)
    }
    
    func testViewDidLoad_SearchBarDelegateShouldNotBeNil() {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchBar.delegate)
    }
    
    
}
