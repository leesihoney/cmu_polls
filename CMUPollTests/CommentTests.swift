//
//  CommentTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//


import Foundation
import XCTest
@testable import CMUPoll


class CommentTests: XCTestCase {

  func testInitializeComment() {
    let aiden = User(first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
    
    let Poll1 = Poll(user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
                     
    let Comment1 = Comment(content: "This poll is fun", user_id: aiden.id, comment_id: nil ,poll_id: Poll1.id, documentId: "It is a document for model: Comment")
    let Comment2 = Comment(content: "I like your comment man", user_id: aiden.id, comment_id: Comment1.id, poll_id: Poll1.id, documentId: "It is a document for model: Comment")
    let Comment3 = Comment(content: "I like your comment too", user_id: aiden.id, comment_id: Comment2.id, poll_id: Poll1.id, documentId: "It is a document for model: Comment")
        
    XCTAssertEqual(Comment1.user_id, aiden.id)
    XCTAssertEqual(Comment1.comment_id, nil)
    XCTAssertEqual(Comment2.comment_id, Comment1.id)
    XCTAssertEqual(Comment3.comment_id, Comment2.id)
  }
  
  func testFuncComment() {
  }
}
