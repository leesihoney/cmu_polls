//
//  UserTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class UserTests: XCTestCase {
  var colRef: CollectionReference?
  var users: [User]?
  var User0, User1: User?
  
  func setUser0() {
    let expectation = self.expectation(description: "Initialize users")
    User.withId(id: "0", completion: { user in
      self.User0 = user
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setUser1() {
    let expectation = self.expectation(description: "Initialize users")
    User.withId(id: "1", completion: { user in
      self.User1 = user
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .user)
    setUser0()
    setUser1()
  }
  
  func testInitializeUsers() {
    XCTAssertEqual(User0!.id, "0")
    XCTAssertEqual(User0!.first_name, "Aiden")
    XCTAssertEqual(User0!.last_name, "Lee")
    XCTAssertEqual(User0!.email, "yonghool@andrew.cmu.edu")
    XCTAssertEqual(User0!.major, "Information Systems")
    XCTAssertEqual(User0!.graduation_year, 2020)
    
    XCTAssertEqual(User1!.id, "1")
    XCTAssertEqual(User1!.first_name, "Andrew")
    XCTAssertEqual(User1!.last_name, "Lee")
    XCTAssertEqual(User1!.email, "siheonl@andrew.cmu.edu")
    XCTAssertEqual(User1!.major, "Information Systems")
    XCTAssertEqual(User1!.graduation_year, 2020)
  }
  
  func testAddPoints0() {
    User0?.addPoints(type: .comment)
    XCTAssertEqual(User0!.points, 1235)
    User0?.addPoints(type: .upload)
    XCTAssertEqual(User0!.points, 1245)
  }
  
  func testAddPoints1() {
    User1?.addPoints(type: .upload)
    User1?.addPoints(type: .upload)
    User1?.addPoints(type: .answer)
    XCTAssertEqual(User1!.points, 4149)
  }
  
  func testPolls0() {
    let expectation = self.expectation(description: "Fetch polls0")
    User0!.polls(completion: { polls in
      XCTAssertEqual(2, polls.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testPolls1() {
    let expectation = self.expectation(description: "Fetch polls1")
    User1!.polls(completion: { polls in
      XCTAssertEqual(3, polls.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }


  func testLikes0() {
    let expectation = self.expectation(description: "Fetch likes0")
    User0!.likes(completion: { likes in
      XCTAssertEqual(2, likes.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testLikes1() {
    let expectation = self.expectation(description: "Fetch likes1")
    User1!.likes(completion: { likes in
      XCTAssertEqual(3, likes.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testComments0() {
    let expectation = self.expectation(description: "Fetch comments0")
    User0!.comments(completion: { comments in
      XCTAssertEqual(5, comments.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testComments1() {
    let expectation = self.expectation(description: "Fetch comments1")
    User1!.comments(completion: { comments in
      XCTAssertEqual(2, comments.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

}
