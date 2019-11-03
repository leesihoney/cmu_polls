//
//  OptionTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll


class OptionTests: XCTestCase {

  func testInitializeOption() {
    let aiden = User(first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
    
    let Poll1 = Poll(user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
       
    let Question1 = Question(is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
        
    let option1 = Option(text: "this is option text!", question_id: Question1.id, documentId: "It is a document for model: Option")
    
    XCTAssertEqual(option1.question_id, Question1.id)
    XCTAssertEqual(option1.text, "this is option text!")
  }
  
  func testFuncOption() {
  }
}
  
