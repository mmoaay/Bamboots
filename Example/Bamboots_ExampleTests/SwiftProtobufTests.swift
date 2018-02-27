//
//  SwiftProtobufTests.swift
//  Bamboots_Tests
//
//  Created by sun on 2018/2/27.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
import Alamofire
import Bamboots
import SwiftProtobuf


struct WeatherForm: RequestFormable {
    func headers() -> [String : String] {
        return [:]
    }

    func parameters() -> [String: Any] {
        return [:]
    }

    var url = "http://127.0.0.1:8080/pbdemo"
}

class SwiftProtobufTests: XCTestCase, Requestable {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAlamofireProtobuf() {
        let exp = self.expectation(description: "Alamofire Protobuf Test")
        Alamofire
        .request("http://127.0.0.1:8080/pbdemo")
        .responsePBObject { (resp: DataResponse<Result>) in
            if resp.result.isSuccess {
                print(resp.result.value!)
            } else {
                print(resp.result.error!)
                assert(false, "Bamboots Protobuf Test failure")
            }
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testBambootsProtobuf() {

        let exp = self.expectation(description: "Bamboots Protobuf Test")
        request(WeatherForm())
        .responsePBObject { (resp: DataResponse<Result>) in
            if resp.result.isSuccess {
                print(resp.result.value!)
            } else {
                print(resp.result.error!)
                assert(false, "Bamboots Protobuf Test failure")
            }
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    
}
