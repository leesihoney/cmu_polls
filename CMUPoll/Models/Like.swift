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
  var id: String
  var user_id: String
  var poll_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, user_id: String, poll_id: String) {
    self.id = id
    self.user_id = user_id
    self.poll_id = poll_id
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(user_id: String, poll_id: String, completion: @escaping (Like) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .like)
    let data: [String:Any] = ["user_id": user_id, "poll_id": poll_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let like = Like(id: documentId, user_id: user_id, poll_id: poll_id)
      completion(like)
    })
  }
  
  static func withId(id: String, completion: @escaping (Like?) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .like).whereField("id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let likes: [Like] = ModelParser.parse(collection: .like, data: data) as! [Like]
        completion(likes[0])
      }
    })
  }
  
  func user(completion: @escaping (User) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .user).whereField("id", isEqualTo: user_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
      completion(users[0])
    })
  }
  
  func poll(completion: @escaping (Poll) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("id", isEqualTo: poll_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      completion(polls[0])
    })
  }
  
  func delete() {
    let docRef = FirebaseDataHandler.docRef(collection: .like, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef)
  }
}
