//
//  Like.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Like: Identifiable {
  var id = UUID()
  var user_id : UUID
  var poll_id : UUID
  var documentId: String = "It is a document for model: Like"
  
  init (user_id: UUID, poll_id: UUID, documentId: String){
    self.user_id = user_id
    self.poll_id = poll_id
    self.documentId = documentId
  }
}
