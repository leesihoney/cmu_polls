//
//  Answer.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Answer: Identifiable {
  var id = UUID()
  var user_id : UUID
  var question_id: UUID
  var option_id: UUID
  var documentId: String = "It is a document for model: Answer"
  
  init (user_id: UUID, question_id: UUID, option_id: UUID, documentId: String) {
    self.user_id = user_id
    self.question_id = question_id
    self.option_id = option_id
    self.documentId = documentId
  }
}
