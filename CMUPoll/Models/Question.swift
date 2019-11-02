//
//  Question.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Question: Identifiable {
  var id = UUID()
  var is_multiple_choice: Bool
  var title: String
  var poll_id : UUID
  var documentId: String = "It is a document for model: Question"
  
  init (is_multiple_choice: Bool, title: String, poll_id: UUID, documentId: String) {
    self.is_multiple_choice = is_multiple_choice
    self.title = title
    self.poll_id = poll_id
    self.documentId = documentId
  }  
}
