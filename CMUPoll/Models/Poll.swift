//
//  Poll.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Poll: Identifiable {
  var id = UUID()
  var user_id : UUID
  var title : String
  var description: String
  var posted_at: Date = Date()
  var link: String
  var is_private: Bool
  var is_closed: Bool = false
  var documentId: String = "It is a document for model: Poll"
  
  init (user_id: UUID, title: String, description: String, link: String, is_private: Bool, documentId: String) {
    self.user_id = user_id
    self.title = title
    self.description = description
    self.link = link
    self.is_private = is_private
    self.documentId = documentId
  }
}
