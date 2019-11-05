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
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, name: String) {
    self.id = id
    self.name = name
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(name: String, completion: @escaping (Tag) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .tag)
    let data: [String:Any] = ["name": name]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let tag = Tag(id: documentId, name: name)
      completion(tag)
    })
  }
  
  func polls(completion: @escaping ([Poll]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .polltag).whereField("tag_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polltags: [PollTag] = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
      var polls: [Poll] = []
      for polltag in polltags {
        let pollQuery = FirebaseDataHandler.colRef(collection: .poll).whereField("id", isEqualTo: polltag.poll_id)
        FirebaseDataHandler.get(query: pollQuery, completion: { data in
          let pollsFound: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
          polls.append(pollsFound[0]) // Assuming there's only one poll for 'polltag.poll_id'
        })
      }
      completion(polls)
    })
  }
}
