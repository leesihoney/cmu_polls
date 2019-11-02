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
  var id = UUID()
  var content: String
  var posted_at: Date = Date()
  var user_id: UUID
  var comment_id: UUID?
  var poll_id: UUID
  var documentId: String = "It is a document for model: Like"
  
  init (content: String, user_id: UUID, comment_id: UUID?, poll_id: UUID, documentId: String) {
    self.content = content
    self.user_id = user_id
    self.comment_id = comment_id
    self.poll_id = poll_id
    self.documentId = documentId
  }  
}
