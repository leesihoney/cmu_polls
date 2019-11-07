//
//  Comment.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Comment: Identifiable {
  var id: String
  var content: String
  var posted_at: Date = Date()
  var user_id: String
  var comment_id: String?
  var poll_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, content: String, user_id: String, comment_id: String?, poll_id: String) {
    self.id = id
    self.content = content
    self.user_id = user_id
    self.comment_id = comment_id
    self.poll_id = poll_id
  }
    
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(content: String, user_id: String, comment_id: String?, poll_id: String, completion: @escaping (Comment) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .comment)
    let data: [String:Any] = ["content": content, "user_id": user_id, "comment_id": comment_id as Any, "poll_id": poll_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let comment = Comment(id: documentId, content: content, user_id: user_id, comment_id: comment_id, poll_id: poll_id)
      completion(comment)
    })
  }
  
  static func withId(id: String, completion: @escaping (Comment?) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .user).whereField("id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let comments: [Comment] = ModelParser.parse(collection: .comment, data: data) as! [Comment]
        completion(comments[0])
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
  
  mutating func update(content: String?, user_id: String?, comment_id: String?, poll_id: String?) {
    let docRef = FirebaseDataHandler.docRef(collection: .comment, documentId: id)
    var data: [String:Any] = [:]
    if let content = content {
      data["content"] = content
      self.content = content
    }
    if let user_id = user_id {
      data["user_id"] = user_id
      self.user_id = user_id
    }
    if let comment_id = comment_id {
      data["comment_id"] = comment_id
      self.comment_id = comment_id
    }
    if let poll_id = poll_id {
      data["poll_id"] = poll_id
      self.poll_id = poll_id
    }
    FirebaseDataHandler.update(docRef: docRef, data: data)
  }
  
  func delete() {
    let docRef = FirebaseDataHandler.docRef(collection: .comment, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef)
  }
}
