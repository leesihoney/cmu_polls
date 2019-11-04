//
//  Tag.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Tag: Identifiable {
  var id: String
  var name: String
  
  init (id: String, name: String) {
    self.id = id
    self.name = name
  }
  
  func countAllPolls() {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("tag_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .poll, data: data)
      print(instances.count)
    })
  }
}
