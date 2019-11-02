//
//  TagTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//


import Foundation
import XCTest
@testable import CMUPoll


class TagTests: XCTestCase {
  let TagIS = Tag(name: "IS", documentId: "It is a document for model: Tag")
  let TagLife = Tag(name: "Life", documentId: "It is a document for model: Tag")
  let TagFood = Tag(name: "Food", documentId: "It is a document for model: Tag")

  func testInitializeTag() {
    
    XCTAssertNotEqual(TagIS.documentId, "It is a document for model: Tag")
    XCTAssertNotEqual(TagIS.id, TagLife.id)
    XCTAssertNotEqual(TagIS.name, TagLife.name)
    XCTAssertNotEqual(TagLife.name, TagFood.name)
  }
  
  func testFuncTag() {
    
    let Poll1 = Poll(user_id: UUID(), title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
    
    let Poll2 = Poll(user_id: UUID(), title: "what is your favorite place to eat in CMU?",  description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
    
    let PollTag1 = PollTag(poll_id: Poll1.id, tag_id: TagIS.id, documentId: "It is a document for model: PollTag")
    let PollTag2 = PollTag(poll_id: Poll2.id, tag_id: TagLife.id, documentId: "It is a document for model: PollTag")
    let PollTag3 = PollTag(poll_id: Poll2.id, tag_id: TagFood.id, documentId: "It is a document for model: PollTag")
    
    XCTAssertEqual(TagIS.countAllPolls(), 1)
    XCTAssertEqual(TagLife.countAllPolls(), 1)
    XCTAssertEqual(TagFood.countAllPolls(), 1)       
  }
}
  
