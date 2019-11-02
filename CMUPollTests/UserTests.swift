//
//  UserTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll


class UserTests: XCTestCase {
  let aiden = User(first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
  let sungho = User(first_name: "Sungho", last_name: "Cho", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
  let andrew = User(first_name: "Andrew", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
    
  func testInitializeUser() {
    
    XCTAssertEqual(aiden.major, "IS")
    XCTAssertEqual(aiden.major, sungho.major)
    XCTAssertEqual(aiden.major, andrew.major)
    
    XCTAssertEqual(aiden.graduation_year, 2020)
    XCTAssertEqual(aiden.graduation_year, sungho.graduation_year)
    XCTAssertEqual(aiden.graduation_year, andrew.graduation_year)

    XCTAssertEqual(aiden.last_name, "Lee")
    XCTAssertEqual(aiden.last_name, andrew.last_name)
    XCTAssertNotEqual(aiden.last_name, sungho.last_name)
    XCTAssertNotEqual(andrew.last_name, sungho.last_name)
    
    XCTAssertNotEqual(aiden.id, andrew.id)
    XCTAssertNotEqual(andrew.id, sungho.id)
        
    XCTAssertEqual(aiden.points, 0)
    XCTAssertEqual(aiden.points, andrew.points)
    XCTAssertEqual(andrew.points, sungho.points)
  }
  
  func testFuncUser() {    
    
    XCTAssertEqual(aiden.points, 0)
    aiden.addpoints(type: "Upload")
    XCTAssertEqual(aiden.points, 10)
    aiden.addpoints(type: "Answer")
    XCTAssertEqual(aiden.points, 15)
    
    aiden.addpoints(type: "Comment")
    XCTAssertEqual(aiden.points, 20)
    
    XCTAssertEqual(sungho.points, 0)
    sungho.addpoints(type: "Comment")
    XCTAssertEqual(aiden.points, 5)
    
    aiden.createPoll()
    aiden.createPoll()
    aiden.createPoll()
    aiden.createPoll()
    XCTAssertEqual(aiden.countPoll(), 4)
    XCTAssertEqual(sungho.countPoll(), 0)
    XCTAssertEqual(andrew.countPoll(), 0)
  }  
}
