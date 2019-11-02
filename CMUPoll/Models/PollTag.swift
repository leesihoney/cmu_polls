//
//  PollTag.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct PollTag: Identifiable {
  var id = UUID()
  var poll_id : UUID
  var tag_id: UUID
  var documentId: String = "It is a document for model: PollTag"
  
  init (poll_id: UUID, tag_id: UUID, documentId: String) {
    self.poll_id = poll_id
    self.tag_id = tag_id
    self.documentId = documentId
  }  
}
