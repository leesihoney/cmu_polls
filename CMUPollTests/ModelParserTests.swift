//
//  ModelParserTests.swift
//  CMUPollTests
//
//  Created by Sung on 12/6/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import CMUPoll

class ModelParserTests: XCTestCase {
  func testPolls() {
    let expectation = self.expectation(description: "Test polls")
    let colRef = FirebaseDataHandler.colRef(collection: .poll)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let polls = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      XCTAssertEqual(10, polls.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  
  
  func testLikes() {
    let expectation = self.expectation(description: "Test likes")
    let colRef = FirebaseDataHandler.colRef(collection: .like)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let likes = ModelParser.parse(collection: .like, data: data) as! [Like]
      XCTAssertEqual(20, likes.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testUsers() {
    let expectation = self.expectation(description: "Test users")
    let colRef = FirebaseDataHandler.colRef(collection: .user)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let users = ModelParser.parse(collection: .user, data: data) as! [User]
      XCTAssertEqual(6, users.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testComments() {
    let expectation = self.expectation(description: "Test comments")
    let colRef = FirebaseDataHandler.colRef(collection: .comment)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let comments = ModelParser.parse(collection: .comment, data: data) as! [Comment]
      XCTAssertEqual(10, comments.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testPollTags() {
    let expectation = self.expectation(description: "Test polltags")
    let colRef = FirebaseDataHandler.colRef(collection: .polltag)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let polltags = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
      XCTAssertEqual(20, polltags.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testTags() {
    let expectation = self.expectation(description: "Test tags")
    let colRef = FirebaseDataHandler.colRef(collection: .tag)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let tags = ModelParser.parse(collection: .tag, data: data) as! [Tag]
      XCTAssertEqual(14, tags.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testQuestions() {
    let expectation = self.expectation(description: "Test questions")
    let colRef = FirebaseDataHandler.colRef(collection: .question)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let questions = ModelParser.parse(collection: .question, data: data) as! [Question]
      XCTAssertEqual(11, questions.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testAnswers() {
    let expectation = self.expectation(description: "Test answers")
    let colRef = FirebaseDataHandler.colRef(collection: .answer)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let answers = ModelParser.parse(collection: .answer, data: data) as! [Answer]
      XCTAssertEqual(20, answers.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testOptions() {
    let expectation = self.expectation(description: "Test options")
    let colRef = FirebaseDataHandler.colRef(collection: .option)
    FirebaseDataHandler.get(colRef: colRef) { data in
      let options = ModelParser.parse(collection: .option, data: data) as! [Option]
      XCTAssertEqual(30, options.count)
      expectation.fulfill()
    }
    self.waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testCustomPolls() {
    let data: FirebaseData = [
      "id": "111",
      "user_id": "222",
      "title": "Test title",
      "description": "Test description",
      "posted_at": "2019-12-05 12:05:59",
      "private": false,
      "closed": false,
    ]
    let polls = ModelParser.parse(collection: .poll, data: [data]) as! [Poll]
    let poll = polls[0]
    XCTAssertEqual("111", poll.id)
    XCTAssertEqual("222", poll.user_id)
    XCTAssertEqual("Test title", poll.title)
    XCTAssertEqual("Test description", poll.description)
    XCTAssertEqual("2019-12-05 12:05:59", poll.posted_at)
  }
  
  func testCustomLikes() {
    let data: FirebaseData = [
      "id": "111",
      "user_id": "222",
      "poll_id": "333",
    ]
    let likes = ModelParser.parse(collection: .like, data: [data]) as! [Like]
    let like = likes[0]
    XCTAssertEqual("111", like.id)
    XCTAssertEqual("222", like.user_id)
    XCTAssertEqual("333", like.poll_id)
  }
  
  func testCustomUsers() {
    let data: FirebaseData = [
      "id": "111",
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@andrew.cmu.edu",
      "major": "Psychology",
      "graduation_year": 2010,
      "points": 500,
    ]
    let users = ModelParser.parse(collection: .user, data: [data]) as! [User]
    let user = users[0]
    XCTAssertEqual("111", user.id)
    XCTAssertEqual("John", user.first_name)
    XCTAssertEqual("Doe", user.last_name)
    XCTAssertEqual("john.doe@andrew.cmu.edu", user.email)
    XCTAssertEqual("Psychology", user.major)
    XCTAssertEqual(2010, user.graduation_year)
    XCTAssertEqual(500, user.points)
  }
  
  func testCustomComments() {
    let data: FirebaseData = [
      "id": "111",
      "content": "Test content",
      "posted_at": "2019-12-05 12:05:59",
      "user_id": "222",
      "poll_id": "333",
    ]
    let comments = ModelParser.parse(collection: .comment, data: [data]) as! [Comment]
    let comment = comments[0]
    XCTAssertEqual("111", comment.id)
    XCTAssertEqual("Test content", comment.content)
    XCTAssertEqual("2019-12-05 12:05:59", comment.posted_at)
    XCTAssertEqual("222", comment.user_id)
    XCTAssertEqual("333", comment.poll_id)
  }
  
  func testCustomPollTags() {
    let data: FirebaseData = [
      "id": "111",
      "poll_id": "222",
      "tag_id": "333",
    ]
    let polltags = ModelParser.parse(collection: .polltag, data: [data]) as! [PollTag]
    let polltag = polltags[0]
    XCTAssertEqual("111", polltag.id)
    XCTAssertEqual("222", polltag.poll_id)
    XCTAssertEqual("333", polltag.tag_id)
  }
  
  func testCustomTags() {
    let data: FirebaseData = [
      "id": "111",
      "name": "Test name",
    ]
    let tags = ModelParser.parse(collection: .tag, data: [data]) as! [Tag]
    let tag = tags[0]
    XCTAssertEqual("111", tag.id)
    XCTAssertEqual("Test name", tag.name)
  }
  
  func testCustomQuestions() {
    let data: FirebaseData = [
      "id": "111",
      "is_multiple_choice": false,
      "title": "Test title",
      "poll_id": "222",
    ]
    let questions = ModelParser.parse(collection: .question, data: [data]) as! [Question]
    let question = questions[0]
    XCTAssertEqual("111", question.id)
    XCTAssertEqual(false, question.is_multiple_choice)
    XCTAssertEqual("Test title", question.title)
    XCTAssertEqual("222", question.poll_id)
  }
  
  func testCustomAnswers() {
    let data: FirebaseData = [
      "id": "111",
      "user_id": "222",
      "question_id": "333",
      "option_id": "444",
    ]
    let answers = ModelParser.parse(collection: .answer, data: [data]) as! [Answer]
    let answer = answers[0]
    XCTAssertEqual("111", answer.id)
    XCTAssertEqual("222", answer.user_id)
    XCTAssertEqual("333", answer.question_id)
    XCTAssertEqual("444", answer.option_id)
  }
  
  func testCustomOptions() {
    let data: FirebaseData = [
      "id": "111",
      "text": "Test text",
      "question_id": "222",
    ]
    let options = ModelParser.parse(collection: .option, data: [data]) as! [Option]
    let option = options[0]
    XCTAssertEqual("111", option.id)
    XCTAssertEqual("Test text", option.text)
    XCTAssertEqual("222", option.question_id)
  }
}
