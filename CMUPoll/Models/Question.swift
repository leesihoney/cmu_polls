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
  var id: String
  var is_multiple_choice: Bool
  var title: String
  var poll_id: String
  
  init (id: String, is_multiple_choice: Bool, title: String, poll_id: String) {
    self.id = id
    self.is_multiple_choice = is_multiple_choice
    self.title = title
    self.poll_id = poll_id
  }
  
  func countAllOption() {
    let query = FirebaseDataHandler.colRef(collection: .option).whereField("question_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .option, data: data)
      print(instances.count)
    })
  }
}
