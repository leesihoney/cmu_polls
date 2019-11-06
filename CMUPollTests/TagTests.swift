//
//  TagTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class TagTests: XCTestCase {
  var colRef: CollectionReference?
  var Tag0, Tag1: Tag?
  
  func setTag0() {
    let expectation = self.expectation(description: "Initialize tags")
    Tag.withId(id: "0", completion: { tag in
      self.Tag0 = tag
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setTag1() {
    let expectation = self.expectation(description: "Initialize tags")
    Tag.withId(id: "1", completion: { tag in
      self.Tag1 = tag
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .tag)
    setTag0()
    setTag1()
  }
  
  func testInitializeTags() {
    XCTAssertEqual(Tag0!.id, "0")
    XCTAssertEqual(Tag0!.name, "Life")
    
    XCTAssertEqual(Tag1!.id, "1")
    XCTAssertEqual(Tag1!.name, "Food")
  }
      
  func testPolls0() {
    let expectation = self.expectation(description: "Fetch polls0")
    Tag0!.polls(completion: { polls in
      XCTAssertEqual(1, polls.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testPolls1() {
    let expectation = self.expectation(description: "Fetch polls1")
    Tag1!.polls(completion: { polls in
      XCTAssertEqual(1, polls.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
}
