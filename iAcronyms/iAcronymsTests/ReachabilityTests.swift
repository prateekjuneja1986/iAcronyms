//
//  ReachabilityTests.swift
//  iAcronymsTests
//
//  Created by Prateek Juneja on 30/01/23.
//


import XCTest
@testable import iAcronyms

class ReachabilityTests: XCTestCase {
    
    var sut: Reachability!
    
    override func setUpWithError() throws {
        sut = Reachability()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testReachability() {
        XCTAssertTrue(sut.isReachable)
    }
    
    func testReachableViaWWAN() {
        XCTAssertFalse(sut.isReachableViaWWAN)
    }
    
    func testReachableViaWiFi() {
        XCTAssertTrue(sut.isReachableViaWiFi)
    }
    
    func testValidHost() {
        let validHostName = "google.com"
        
        guard let reachability = Reachability(hostname: validHostName) else {
            return XCTFail("Unable to create reachability")
        }
        
        let expected = expectation(description: "Check for valid host")
        reachability.whenReachable = { reachability in
            print("Pass: \(validHostName) is reachable - \(reachability)")

            // Only fulfill the expectation on host reachable
            expected.fulfill()
        }
        reachability.whenUnreachable = { reachability in
            print("\(validHostName) is initially unreachable - \(reachability)")
            // Expectation isn't fulfilled here, so wait will time out if this is the only closure called
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            return XCTFail("Unable to start notifier")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        reachability.stopNotifier()
    }

    func testInvalidHost() {
        // Testing with an invalid host will initially show as reachable, but then the callback
        // gets fired a second time reporting the host as unreachable

        let invalidHostName = "invalidhost"

        guard let reachability = Reachability(hostname: invalidHostName) else {
            return XCTFail("Unable to create reachability")
        }
        
        let expected = expectation(description: "Check invalid host")
        reachability.whenReachable = { reachability in
            print("\(invalidHostName) is initially reachable - \(reachability)")
        }
        
        reachability.whenUnreachable = { reachability in
            print("Pass: \(invalidHostName) is unreachable - \(reachability))")
            expected.fulfill()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            return XCTFail("Unable to start notifier")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        reachability.stopNotifier()
    }

}
