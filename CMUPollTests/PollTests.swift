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
  let aiden = User(id: "1", first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020)
  
  func testInitializePoll() {
    let Poll1 = Poll(id: "1", user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false)
        
    XCTAssertEqual(Poll1.user_id, aiden.id)
    XCTAssertEqual(Poll1.is_private, false)
    XCTAssertEqual(Poll1.is_closed, false)
    XCTAssertEqual(Poll1.title, "who is your favorite IS Professor")
  }
  
  func testFuncPoll() {
    let Poll1 = Poll(id: "1", user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false)
    let Poll2 = Poll(id: "2", user_id: aiden.id, title: "what is your favorite place to eat in CMU?", description: "It is for research study", link: "not available yet", is_private: false)
        
    let Question1 = Question(id: "1", is_multiple_choice: true, title : "what is your major?", poll_id: Poll1.id)
    let Question2 = Question(id: "2", is_multiple_choice: false, title : "what is your gpa?", poll_id: Poll1.id)
    
    let TagIS = Tag(id: "1", name: "IS")
    let TagLife = Tag(id: "2", name: "Life")
    let TagFood = Tag(id: "3", name: "Food")
  
    let PollTag1 = PollTag(id: "1", poll_id: Poll1.id, tag_id: TagIS.id)
    let PollTag2 = PollTag(id: "2", poll_id: Poll2.id, tag_id: TagLife.id)
    let PollTag3 = PollTag(id: "3", poll_id: Poll2.id, tag_id: TagFood.id)
            
    let like1 = Like(id: "1", user_id: aiden.id, poll_id: Poll1.id)
         
    XCTAssertEqual(Poll1.countAllQuestion(), 2)
    XCTAssertEqual(Poll2.countAllQuestion(), 0)
    
    XCTAssertEqual(Poll1.countAllTag(), 1)
    XCTAssertEqual(Poll2.countAllTag(), 2)
        
    XCTAssertEqual(Poll1.countAllLike(), 1)
    XCTAssertEqual(Poll2.countAllLike(), 0)
  }
}
  
