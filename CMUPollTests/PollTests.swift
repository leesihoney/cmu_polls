//
//  PollTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class PollTests: XCTestCase {
  var aiden: User = User(id: "1", first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020)
  var colRef: CollectionReference?
  var polls: [Poll]?
  var Poll0, Poll1, Poll2: Poll?
  
  func setPoll0() {
    let expectation = self.expectation(description: "Initialize polls")
    Poll.withId(id: "0", completion: { poll in
      self.Poll0 = poll
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setPoll1() {
    let expectation = self.expectation(description: "Initialize polls")
    Poll.withId(id: "1", completion: { poll in
      self.Poll1 = poll
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .poll)
    setPoll0()
    setPoll1()
  }
  
  func testInitializePoll() {
    XCTAssertEqual(Poll0!.user_id, "0")
    XCTAssertEqual(Poll0!.is_private, false)
    XCTAssertEqual(Poll0!.is_closed, false)
    XCTAssertEqual(Poll0!.title, "Where is the best place to eat in CMU?")
    
    XCTAssertEqual(Poll1!.user_id, "0")
    XCTAssertEqual(Poll1!.is_private, false)
    XCTAssertEqual(Poll1!.is_closed, false)
    XCTAssertEqual(Poll1!.title, "Who is your favorite Information Systems professor?")
  }
  
  func testQuestions0() {
    let expectation = self.expectation(description: "Fetch questions0")
    Poll0!.questions(completion: { questions in
      XCTAssertEqual(2, questions.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testQuestions1() {
    let expectation = self.expectation(description: "Fetch questions1")
    Poll1!.questions(completion: { questions in
      XCTAssertEqual(1, questions.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testTags0() {
    let expectation = self.expectation(description: "Fetch tags0")
    Poll0!.tags(completion: { tags in
      XCTAssertEqual(3, tags.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testTags1() {
    let expectation = self.expectation(description: "Fetch tags1")
    Poll1!.tags(completion: { tags in
      XCTAssertEqual(3, tags.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testLikes0() {
    let expectation = self.expectation(description: "Fetch likes0")
    Poll0!.likes(completion: { likes in
      XCTAssertEqual(2, likes.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testLikes1() {
    let expectation = self.expectation(description: "Fetch likes1")
    Poll1!.likes(completion: { likes in
      XCTAssertEqual(4, likes.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testComments0() {
    let expectation = self.expectation(description: "Fetch comments0")
    Poll0!.comments(completion: { comments in
      XCTAssertEqual(3, comments.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testComments1() {
    let expectation = self.expectation(description: "Fetch comments1")
    Poll1!.comments(completion: { comments in
      XCTAssertEqual(4, comments.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUser0() {
    let expectation = self.expectation(description: "Fetch user0")
    Poll0!.user(completion: { user in
      XCTAssertEqual("0", user.id)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUser1() {
    let expectation = self.expectation(description: "Fetch user1")
    Poll1!.user(completion: { user in
      XCTAssertEqual("0", user.id)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
}
  
