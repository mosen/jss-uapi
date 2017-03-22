//
//  jss_uapiTests.swift
//  jss-uapiTests
//
//  Created by Administrator on 22/3/17.
//  Copyright © 2017 Mosen. All rights reserved.
//

import XCTest
@testable import jss_uapi

class jss_uapiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAuthenticate() {
        let url = URL(string: "https://localhost:8444")!
        let credentials = URLCredential(user: "admin", password: "pa$$W0rd", persistence: URLCredential.Persistence.none)
        let uapi = UAPI(url: url, credential: credentials)
        
        let expect = expectation(description: "URLSession result")
        
        uapi.authenticate() {
            (result) in
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            
        }
    }
    
}
