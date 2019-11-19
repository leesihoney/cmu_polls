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
  var posted_at: String
  var user_id: String
  var comment_id: String?
  var poll_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, content: String, posted_at: String, user_id: String, comment_id: String?, poll_id: String) {
    self.id = id
    self.content = content
    self.posted_at = posted_at
    self.user_id = user_id
    self.comment_id = comment_id
    self.poll_id = poll_id
  }
  
  private static func getDateString() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
  }
    
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(content: String, comment_id: String?, poll_id: String, completion: @escaping (Comment) -> ()) {
    guard let user = User.current else {
      print("No user is logged in!")
      return
    }
    let posted_at: String = getDateString()
    let colRef = FirebaseDataHandler.colRef(collection: .comment)
    let data: [String:Any] = ["content": content, "posted_at": posted_at, "user_id": user.id, "comment_id": comment_id as Any, "poll_id": poll_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let comment = Comment(id: documentId, content: content, posted_at: posted_at, user_id: user.id, comment_id: comment_id, poll_id: poll_id)
      completion(comment)
    })
  }
  
  static func withId(id: String, completion: @escaping (Comment?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .comment, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let comments: [Comment] = ModelParser.parse(collection: .comment, data: data) as! [Comment]
        completion(comments[0])
      }
    })
  }
  
  static func allComments(completion: @escaping ([Comment]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .comment)
      .order(by: "posted_at", descending: true)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allComments: [Comment] = ModelParser.parse(collection: .comment, data: data) as! [Comment]
      completion(allComments)
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
  
  mutating func update(content: String?, user_id: String?, comment_id: String?, poll_id: String?, completion: @escaping () -> Void) {
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
    FirebaseDataHandler.update(docRef: docRef, data: data, completion: completion)
  }
  
  func delete(completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .comment, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef, completion: completion)
  }
}
