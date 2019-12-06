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
  static func create(poll_id: String, completion: @escaping (Like) -> ()) {
    guard let user = User.current else {
      return
    }
    let data: [String:Any] = ["user_id": user.id, "poll_id": poll_id]
    let colRef = FirebaseDataHandler.colRef(collection: .like)
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let like = Like(id: documentId, user_id: user.id, poll_id: poll_id)
      completion(like)
    })
  }
  
  static func withId(id: String, completion: @escaping (Like?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .like, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let likes: [Like] = ModelParser.parse(collection: .like, data: data) as! [Like]
        completion(likes[0])
      }
    })
  }
  
  static func allLikes(completion: @escaping ([Like]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .like)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allLikes: [Like] = ModelParser.parse(collection: .like, data: data) as! [Like]
      completion(allLikes)
    })
  }
  
  func user(completion: @escaping (User) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .user, documentId: user_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
      completion(users[0])
    })
  }
  
  func poll(completion: @escaping (Poll) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: poll_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let polls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      completion(polls[0])
    })
  }
  
  func delete(completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .like, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef, completion: completion)
  }
}
