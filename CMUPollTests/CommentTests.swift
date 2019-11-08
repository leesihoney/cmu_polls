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

class CommentTests: XCTestCase {
  var colRef: CollectionReference?
  var Comment0, Comment1: Comment?
  
  func setComment0() {
    let expectation = self.expectation(description: "Initialize comments")
    Comment.withId(id: "0", completion: { comment in
      self.Comment0 = comment
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setComment1() {
    let expectation = self.expectation(description: "Initialize comments")
    Comment.withId(id: "1", completion: { comment in
      self.Comment1 = comment
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .comment)
    setComment0()
    setComment1()
  }
  
  func testInitializeComments() {
    XCTAssertEqual(Comment0!.id, "0")
    XCTAssertEqual(Comment0!.user_id, "0")
    XCTAssertEqual(Comment0?.comment_id, "NULL")
    XCTAssertEqual(Comment0!.poll_id, "0")
    XCTAssertEqual(Comment0!.content, "I agree with you! I love underground!")
    
    XCTAssertEqual(Comment1!.id, "1")
    XCTAssertEqual(Comment1!.user_id, "0")
    XCTAssertEqual(Comment1!.comment_id, "0")
    XCTAssertEqual(Comment1!.poll_id, "0")
    XCTAssertEqual(Comment1!.content, "Well, I like iNoodle the most")
  }
      
  func testUsers0() {
     let expectation = self.expectation(description: "Fetch users0")
     Comment0!.user(completion: { users in
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
     Comment1!.user(completion: { users in
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
    Comment0!.poll(completion: { polls in
      XCTAssertEqual("0", polls.id)
      XCTAssertEqual("0", polls.user_id)
      XCTAssertEqual("Where is the best place to eat in CMU?", polls.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testPolls1() {
    let expectation = self.expectation(description: "Fetch poll1")
    Comment1!.poll(completion: { polls in
      XCTAssertEqual("0", polls.id)
      XCTAssertEqual("0", polls.user_id)
      XCTAssertEqual("Where is the best place to eat in CMU?", polls.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

}

