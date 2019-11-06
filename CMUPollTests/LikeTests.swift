//
//  AnswerTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class LikeTests: XCTestCase {
  var colRef: CollectionReference?
  var Like0, Like1: Like?
  
  func setLike0() {
    let expectation = self.expectation(description: "Initialize likes")
    Like.withId(id: "0", completion: { like in
      self.Like0 = like
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setLike1() {
    let expectation = self.expectation(description: "Initialize likes")
    Like.withId(id: "1", completion: { like in
      self.Like1 = like
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .like)
    setLike0()
    setLike1()
  }
  
  func testInitializeLikes() {
    XCTAssertEqual(Like0!.id, "0")
    XCTAssertEqual(Like0!.user_id, "0")
    XCTAssertEqual(Like0?.poll_id, "0")
    
    XCTAssertEqual(Like1!.id, "1")
    XCTAssertEqual(Like1!.user_id, "0")
    XCTAssertEqual(Like1?.poll_id, "1")
  }
      
  func testUsers0() {
     let expectation = self.expectation(description: "Fetch users0")
     Like0!.user(completion: { users in
       XCTAssertEqual("0", users.id)
       XCTAssertEqual("Aiden", users.first_name)
       XCTAssertEqual("Lee", users.last_name)
       XCTAssertEqual("Information Systems", users.major)
       expectation.fulfill()
     })
     self.waitForExpectations(timeout: 5.0, handler: nil)
   }

   func testUsers1() {
     let expectation = self.expectation(description: "Fetch users1")
     Like1!.user(completion: { users in
       XCTAssertEqual("0", users.id)
       XCTAssertEqual("Aiden", users.first_name)
       XCTAssertEqual("Lee", users.last_name)
       XCTAssertEqual("Information Systems", users.major)
       expectation.fulfill()
     })
     self.waitForExpectations(timeout: 5.0, handler: nil)
   }
  
  func testPolls0() {
    let expectation = self.expectation(description: "Fetch poll0")
    Like0!.poll(completion: { polls in
      XCTAssertEqual("0", polls.id)
      XCTAssertEqual("0", polls.user_id)
      XCTAssertEqual("Where is the best place to eat in CMU?", polls.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testPolls1() {
    let expectation = self.expectation(description: "Fetch poll1")
    Like1!.poll(completion: { polls in
      XCTAssertEqual("1", polls.id)
      XCTAssertEqual("0", polls.user_id)
      XCTAssertEqual("Who is your favorite Information Systems professor?", polls.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

}

