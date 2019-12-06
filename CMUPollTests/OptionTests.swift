//
//  OptionTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class OptionTests: XCTestCase {
  var colRef: CollectionReference?
  var Option0, Option1: Option?
  
  func setOption0() {
    let expectation = self.expectation(description: "Initialize options")
    Option.withId(id: "0", completion: { option in
      self.Option0 = option
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setOption1() {
    let expectation = self.expectation(description: "Initialize options")
    Option.withId(id: "1", completion: { option in
      self.Option1 = option
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .option)
    setOption0()
    setOption1()
  }
  
  func testInitializeOptions() {
    XCTAssertEqual(Option0!.id, "0")
    XCTAssertEqual(Option0!.question_id, "0")
    XCTAssertEqual(Option0!.text, "iNoodle")
    
    XCTAssertEqual(Option1!.id, "1")
    XCTAssertEqual(Option1!.question_id, "0")
    XCTAssertEqual(Option1!.text, "Tartam Express")
  }
    
  func testQuestions0() {
    let expectation = self.expectation(description: "Fetch question0")
    Option0!.question(completion: { questions in
      XCTAssertEqual("0", questions.id)
      XCTAssertEqual("0", questions.poll_id)
      XCTAssertEqual(true, questions.is_multiple_choice)
      XCTAssertEqual("Where is the best place to eat in CMU?", questions.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testQuestions1() {
    let expectation = self.expectation(description: "Fetch question1")
    Option1!.question(completion: { questions in
      XCTAssertEqual("0", questions.id)
      XCTAssertEqual("0", questions.poll_id)
      XCTAssertEqual(true, questions.is_multiple_choice)
      XCTAssertEqual("Where is the best place to eat in CMU?", questions.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testAnswers0() {
    let expectation = self.expectation(description: "Fetch answers0")
    Option0!.answers(completion: { answers in
      XCTAssertEqual(3, answers.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testAnswers1() {
    let expectation = self.expectation(description: "Fetch answers1")
    Option1!.answers(completion: { answers in
      XCTAssertEqual(0, answers.count)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
}

