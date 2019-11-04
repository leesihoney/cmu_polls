//
//  AnswerTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll

class AnswerTests: XCTestCase {
  
  func testInitializeAnswer() {
    func testFuncLike() {
      let sungho = User(first_name: "Sungho", last_name: "Cho", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
            
      let Poll1 = Poll(user_id: sungho.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: User")
            
      let Question1 = Question(is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
          
      let Option1 = Option(text: "this is option text!", question_id: Question1.id, documentId: "It is a document for model: Option")
      
      let Answer1 = Answer(user_id: sungho.id, question_id: Question1.id, option_id: Option1.id, documentId: "It is a document for model: Answer")
      
      XCTAssertEqual(Answer1.user_id, sungho.id)
      XCTAssertEqual(Answer1.question_id, Question1.id)
      XCTAssertEqual(Answer1.option_id, Option1.id)
    }
  }
  
  func testFuncAnswer() {
  }
}
