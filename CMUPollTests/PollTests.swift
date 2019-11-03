//
//  PollTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll


class PollTests: XCTestCase {
  let aiden = User(first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
  
  func testInitializePoll() {
    let Poll1 = Poll(user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
        
    XCTAssertEqual(Poll1.user_id, aiden.id)
    XCTAssertEqual(Poll1.is_private, false)
    XCTAssertEqual(Poll1.is_closed, false)
    XCTAssertEqual(Poll1.title, "who is your favorite IS Professor")
  }
  
  func testFuncPoll() {
    let Poll1 = Poll(user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
    let Poll2 = Poll(user_id: aiden.id, title: "what is your favorite place to eat in CMU?", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
        
    let Question1 = Question(is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
    let Question2 = Question(is_multiple_choice: false, title : "what is your gpa?", poll_id: Poll1.id, documentId: "It is a document for model: Question")
    
    let TagIS = Tag(name: "IS", documentId: "It is a document for model: Tag")
    let TagLife = Tag(name: "Life", documentId: "It is a document for model: Tag")
    let TagFood = Tag(name: "Food", documentId: "It is a document for model: Tag")
  
    let PollTag1 = PollTag(poll_id: Poll1.id, tag_id: TagIS.id, documentId: "It is a document for model: PollTag")
    let PollTag2 = PollTag(poll_id: Poll2.id, tag_id: TagLife.id, documentId: "It is a document for model: PollTag")
    let PollTag3 = PollTag(poll_id: Poll2.id, tag_id: TagFood.id, documentId: "It is a document for model: PollTag")
            
    let like1 = Like(user_id: aiden.id, poll_id: Poll1.id, documentId: "It is a document for model: Like")
         
    XCTAssertEqual(Poll1.countAllQuestion(), 2)
    XCTAssertEqual(Poll2.countAllQuestion(), 0)
    
    XCTAssertEqual(Poll1.countAllTag(), 1)
    XCTAssertEqual(Poll2.countAllTag(), 2)
        
    XCTAssertEqual(Poll1.countAllLike(), 1)
    XCTAssertEqual(Poll2.countAllLike(), 0)
  }
}
  
