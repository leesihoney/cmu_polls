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

class AnswerTests: XCTestCase {
  var colRef: CollectionReference?
  var Answer0, Answer1: Answer?
  
  func setAnswer0() {
    let expectation = self.expectation(description: "Initialize answers")
    Answer.withId(id: "0", completion: { answer in
      self.Answer0 = answer
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func setAnswer1() {
    let expectation = self.expectation(description: "Initialize answers")
    Answer.withId(id: "1", completion: { answer in
      self.Answer1 = answer
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  override func setUp() {
    super.setUp()
    self.colRef = FirebaseDataHandler.colRef(collection: .answer)
    setAnswer0()
    setAnswer1()
  }
  
  func testInitializeAnswers() {
    XCTAssertEqual(Answer0!.id, "0")
    XCTAssertEqual(Answer0!.user_id, "0")
    XCTAssertEqual(Answer0!.question_id, "0")
    XCTAssertEqual(Answer0!.option_id, "0")
    
    XCTAssertEqual(Answer1!.id, "1")
    XCTAssertEqual(Answer1!.user_id, "0")
    XCTAssertEqual(Answer1!.question_id, "1")
    XCTAssertEqual(Answer1!.option_id, "3")
  }
  
  func testQuestions0() {
    let expectation = self.expectation(description: "Fetch question0")
    Answer0!.question(completion: { questions in
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
    Answer1!.question(completion: { questions in
      XCTAssertEqual("1", questions.id)
      XCTAssertEqual("0", questions.poll_id)
      XCTAssertEqual(true, questions.is_multiple_choice)
      XCTAssertEqual("Where is the best place to eat near CMU?", questions.title)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testOptions0() {
    let expectation = self.expectation(description: "Fetch options0")
    Answer0!.option(completion: { options in
      XCTAssertEqual("0", options.id)
      XCTAssertEqual("0", options.question_id)
      XCTAssertEqual("iNoodle", options.text)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testOptions1() {
    let expectation = self.expectation(description: "Fetch options1")
    Answer1!.option(completion: { options in
      XCTAssertEqual("3", options.id)
      XCTAssertEqual("1", options.question_id)
      XCTAssertEqual("Union Grill", options.text)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUsers0() {
    let expectation = self.expectation(description: "Fetch users0")
    Answer0!.user(completion: { users in
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
    Answer1!.user(completion: { users in
      XCTAssertEqual("0", users.id)
      XCTAssertEqual("Aiden", users.first_name)
      XCTAssertEqual("Lee", users.last_name)
      XCTAssertEqual("Information Systems", users.major)
      expectation.fulfill()
    })
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testAllAnswers() {
    let expectation = self.expectation(description: "Test allAnswers")
    Answer.allAnswers() { answers in
      XCTAssertEqual(20, answers.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  
  func testWithQuestionUser() {
    let expectation = self.expectation(description: "Test allAnswers")
    Answer.withQuestionUser(question_id: "0", user_id: "0") { answer in
      XCTAssertEqual("0", answer!.id)
      XCTAssertEqual("0", answer!.question_id)
      XCTAssertEqual("0", answer!.user_id)
      XCTAssertEqual("0", answer!.option_id)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  
  func testCreateUpdateDelete() {
    let expectation = self.expectation(description: "Test create update delete")
    User.withId(id: "2") { user in
      User.current = user
      Answer.create(question_id: "1", option_id: "1") { answer in
        XCTAssertEqual("1", answer.question_id)
        XCTAssertEqual("1", answer.option_id)
        answer.update(user_id: user!.id, question_id: "2", option_id: "2") {
          XCTAssertEqual("2", answer.question_id)
          XCTAssertEqual("2", answer.option_id)
          answer.delete {
            expectation.fulfill()
          }
        }
      }
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
}
