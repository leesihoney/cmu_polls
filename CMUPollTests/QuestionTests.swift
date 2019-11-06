//
//  QuestionTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class QuestionTests: XCTestCase {
  var colRef: CollectionReference?
  var Question0, Question1: Question?
  
  func setQuestion0() {
    let expectation = self.expectation(description: "Initialize questions")
    Question.withId(id: "0", completion: { question in
      self.Question0 = question
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setQuestion1() {
    let expectation = self.expectation(description: "Initialize questions")
    Question.withId(id: "1", completion: { question in
      self.Question1 = question
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .question)
    setQuestion0()
    setQuestion1()
  }
  
  func testInitializeQuestions() {
    XCTAssertEqual(Question0!.id, "0")
    XCTAssertEqual(Question0!.poll_id, "0")
    XCTAssertEqual(Question0!.is_multiple_choice, true)
    XCTAssertEqual(Question0!.title, "Where is the best place to eat in CMU?")
    
    XCTAssertEqual(Question1!.id, "1")
    XCTAssertEqual(Question1!.poll_id, "0")
    XCTAssertEqual(Question1!.is_multiple_choice, true)
    XCTAssertEqual(Question1!.title, "Where is the best place to eat near CMU?")
  }
    
  func testOptions0() {
    let expectation = self.expectation(description: "Fetch options0")
    Question0!.options(completion: { options in
      XCTAssertEqual(3, options.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testOptions1() {
    let expectation = self.expectation(description: "Fetch options1")
    Question1!.options(completion: { options in
      XCTAssertEqual(3, options.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testAnswers0() {
    let expectation = self.expectation(description: "Fetch answers0")
    Question0!.answers(completion: { answers in
      XCTAssertEqual(2, answers.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testAnswers1() {
    let expectation = self.expectation(description: "Fetch answers1")
    Question1!.answers(completion: { answers in
      XCTAssertEqual(2, answers.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testPolls0() {
     let expectation = self.expectation(description: "Fetch poll0")
     Question0!.poll(completion: { polls in
       XCTAssertEqual("0", polls.id)
       XCTAssertEqual("0", polls.user_id)
       XCTAssertEqual("Where is the best place to eat in CMU?", polls.title)
       expectation.fulfill()
     })
     self.waitForExpectations(timeout: 5.0, handler: nil)
   }

   func testPolls1() {
     let expectation = self.expectation(description: "Fetch poll1")
     Question1!.poll(completion: { polls in
       XCTAssertEqual("0", polls.id)
       XCTAssertEqual("0", polls.user_id)
       XCTAssertEqual("Where is the best place to eat in CMU?", polls.title)
       expectation.fulfill()
     })
     self.waitForExpectations(timeout: 5.0, handler: nil)
   }

}

