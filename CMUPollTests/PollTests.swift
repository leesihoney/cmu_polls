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
  var aiden: User = User(id: "1", first_name: "Aiden", last_name: "Lee", email: "yonghool@andrew.cmu.edu", major: "IS", graduation_year: 2020, points: nil)
  var colRef: CollectionReference?
  var polls: [Poll]?
  var Poll0, Poll1, Poll6: Poll?
  
  func setPoll0() {
    let expectation = self.expectation(description: "Initialize polls0")
    Poll.withId(id: "0", completion: { poll in
      self.Poll0 = poll
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setPoll1() {
    let expectation = self.expectation(description: "Initialize polls1")
    Poll.withId(id: "1", completion: { poll in
      self.Poll1 = poll
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setPoll6() {
    let expectation = self.expectation(description: "Initialize polls6")
    Poll.withId(id: "6", completion: { poll in
      self.Poll6 = poll
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .poll)
    setPoll0()
    setPoll1()
    setPoll6()
  }
  
  func testInitializePolls() {
    XCTAssertEqual(Poll0!.user_id, "0")
    XCTAssertEqual(Poll0!.is_private, true)
    XCTAssertEqual(Poll0!.is_closed, true)
    XCTAssertEqual(Poll0!.title, "Where is the best place to eat in CMU?")
    
    XCTAssertEqual(Poll1!.user_id, "0")
    XCTAssertEqual(Poll1!.is_private, true)
    XCTAssertEqual(Poll1!.is_closed, false)
    XCTAssertEqual(Poll1!.title, "Who is your favorite Information Systems professor?")
    
    XCTAssertEqual(Poll6!.user_id, "2")
    XCTAssertEqual(Poll6!.is_private, false)
    XCTAssertEqual(Poll6!.is_closed, false)
    XCTAssertEqual(Poll6!.description, "I'm researching on the average sleep hours of CMU students for my sociology class.")
    XCTAssertEqual(Poll6!.title, "How many hours do you normally sleep?")
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
      XCTAssertEqual("yonghoo@andrew.cmu.edu", user?.email)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUser1() {
    let expectation = self.expectation(description: "Fetch user1")
    Poll1!.user(completion: { user in
      XCTAssertEqual("yonghoo@andrew.cmu.edu", user?.email)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUser6() {
    let expectation = self.expectation(description: "Fetch user6")
    XCTAssertEqual("2", Poll6!.user_id)
    Poll6!.user(completion: { user in
      XCTAssertEqual("sunghocho@andrew.cmu.edu", user?.email)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testAllPolls() {
    let expectation = self.expectation(description: "Test allPolls")
    Poll.allPolls() { polls in
      XCTAssertEqual(10, polls.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testSort() {
    let expectation = self.expectation(description: "Test sort")
    Poll.allPolls() { polls in
      XCTAssertEqual(10, polls.count)
      let sorted = Poll.sort(polls)
      XCTAssertEqual(10, sorted.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testDate0() {
    let dateStr = Poll0!.getDateDisplayString()
    // Can't fully test this, because it will show "X days/weeks/months ago" depending on current date
    XCTAssert(dateStr.count > 0)
  }
  
  func testDate1() {
    let dateStr = Poll1!.getDateDisplayString()
    // Can't fully test this, because it will show "X days/weeks/months ago" depending on current date
    XCTAssert(dateStr.count > 0)
  }
  
  func testWithTag0() {
    let expectation = self.expectation(description: "Test withTag0")
    Poll.withTag(name: "Place") { polls in
      XCTAssertEqual(2, polls.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testWithTag1() {
    let expectation = self.expectation(description: "Test withTag1")
    Poll.withTag(name: "tag that does not exist") { polls in
      XCTAssertEqual(0, polls.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testCreateInvalid() {
    User.current = nil
    Poll.create(title: "Test title", description: "Test description", link: "", is_private: false, is_closed: false, passcode: nil) { poll in
      XCTAssertTrue(false)
    }
  }
    
  func testCreateUpdateDelete() {
    let expectation = self.expectation(description: "Test create update delete")
    
    User.withId(id: "2") { user in
      User.current = user
      Poll.create(title: "Test title", description: "test description", link: "", is_private: false, is_closed: true, passcode: nil) { poll in
        XCTAssertEqual("Test title", poll.title)
        XCTAssertEqual("test description", poll.description)
        XCTAssertEqual(false, poll.is_private)
        XCTAssertEqual(true, poll.is_closed)
        poll.update(user_id: nil, title: "new title", description: "new description", link: "new link", is_closed: false, is_private: true, passcode: "0505") {
          XCTAssertEqual("new title", poll.title)
          XCTAssertEqual("new description", poll.description)
          XCTAssertEqual("new link", poll.link)
          XCTAssertEqual(true, poll.is_private)
          XCTAssertEqual(false, poll.is_closed)
          poll.delete {
            expectation.fulfill()
          }
        }
      }
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testAddTag() {
    User.withId(id: "5") { user in
      User.current = user
      Poll.withId(id: "9") { poll in
        poll!.addTags(tagNames: ["Life", "Freshman"])
      }
    }
  }
  
  func testAddTagInvalid() {
    User.current = nil
    Poll.withId(id: "9") { poll in
      poll!.addTags(tagNames: ["Life", "Freshman"])
    }
  }
}
