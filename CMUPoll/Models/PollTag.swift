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
  var id: String
  var poll_id: String
  var tag_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, poll_id: String, tag_id: String) {
    self.id = id
    self.poll_id = poll_id
    self.tag_id = tag_id
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(poll_id: String, tag_id: String, completion: @escaping (PollTag) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .polltag)
    let data: [String:Any] = ["poll_id": poll_id, "tag_id": tag_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let polltag = PollTag(id: documentId, poll_id: poll_id, tag_id: tag_id)
      completion(polltag)
    })
  }
  
  func poll(completion: @escaping (Poll) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("id", isEqualTo: poll_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polls: [Poll] = ModelParser.parse(collection: .user, data: data) as! [Poll]
      completion(polls[0])
    })
  }
  
  func tag(completion: @escaping (Tag) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .tag).whereField("id", isEqualTo: tag_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let tags: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
      completion(tags[0])
    })
  }
  
  func delete() {
    let docRef = FirebaseDataHandler.docRef(collection: .like, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef)
  }
}
