//
//  Comment.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Comment: Identifiable {
  var id: String
  var content: String
  var posted_at: Date = Date()
  var user_id: String
  var comment_id: String?
  var poll_id: String
  
  init (id: String, content: String, user_id: String, comment_id: String?, poll_id: String) {
    self.id = id
    self.content = content
    self.user_id = user_id
    self.comment_id = comment_id
    self.poll_id = poll_id
  }  
}
