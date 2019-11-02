//
//  QuestionTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll


class QuestionTests: XCTestCase {
  let Poll1 = Poll(user_id: UUID(), title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
  
  func testInitializeQuestion() {
    let Question1 = Question(is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
        
    XCTAssertEqual(Question1.is_multiple_choice, true)
    XCTAssertEqual(Question1.title, "what is your major?")
    XCTAssertEqual(Question1.poll_id, Poll1.id)
  }
  
  func testFuncQuestion() {
    let Question1 = Question(is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
    let Question2 = Question(is_multiple_choice: false, title : "what is your gpa?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
               
    let option1 = Option(text: "this is option text_1", question_id: Question1.id, documentId: "It is a document for model: Option")
    let option2 = Option(text: "this is option text_2", question_id: Question1.id, documentId: "It is a document for model: Option")
    let option3 = Option(text: "this is option text_3", question_id: Question1.id, documentId: "It is a document for model: Option")
        
    XCTAssertEqual(Question1.countAllOption(), 3)
    XCTAssertEqual(Question2.countAllOption(), 0)
  }
}
