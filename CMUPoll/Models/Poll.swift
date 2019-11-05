//
//  Poll.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct Poll: Identifiable {
  var id: String
  var user_id: String
  var title : String
  var description: String
  var posted_at: Date = Date()
  var link: String
  var is_private: Bool
  var is_closed: Bool = false
  
  init (id: String, user_id: String, title: String, description: String, link: String, is_private: Bool) {
    self.id = id
    self.user_id = user_id
    self.title = title
    self.description = description
    self.link = link
    self.is_private = is_private
  }
  
  func countAllQuestion() {
    let query = FirebaseDataHandler.colRef(collection: .question).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .question, data: data)
      print(instances.count)
    })
  }
  
  func countAllTag() {
    let query = FirebaseDataHandler.colRef(collection: .tag).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .tag, data: data)
      print(instances.count)
    })
  }
  
  func countAllLike() {
    let query = FirebaseDataHandler.colRef(collection: .like).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .like, data: data)
      print(instances.count)
    })
  }
}
