//
//  LikeTests.swift
//  CMUPollTests
//
//  Created by Aiden Lee on 11/2/19.
//  Copyright © 2019 67442. All rights reserved.
//

import Foundation
import XCTest
@testable import CMUPoll


class LikeTests: XCTestCase {

  func testInitializeLike() {
    let aiden = User(first_name: "Aiden", last_name: "Lee", major: "IS", graduation_year: 2020, documentId: "It is a document for model: User")
    
    let Poll1 = Poll(user_id: aiden.id, title: "who is your favorite IS Professor", description: "It is for research study", link: "not available yet", is_private: false, documentId: "It is a document for model: Poll")
                    
    let like1 = Like(user_id: aiden.id, poll_id: Poll1.id, documentId: "It is a document for model: Like")
    
    XCTAssertEqual(like1.user_id, aiden.id)
    XCTAssertEqual(like1.poll_id, Poll1.id)
  }
  
  func testFuncLike() {
  }
}
