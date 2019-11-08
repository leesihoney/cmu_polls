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

class Poll: Identifiable {
  var id: String
  var user_id: String
  var title : String
  var description: String
  var posted_at: Date = Date()
  var link: String
  var is_private: Bool
  var is_closed: Bool
  
  // Used for double query
  var tagsFound: [Tag] = []
  var numTags: Int?
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, user_id: String, title: String, description: String, link: String, is_private: Bool, is_closed: Bool) {
    self.id = id
    self.user_id = user_id
    self.title = title
    self.description = description
    self.link = link
    self.is_private = is_private
    self.is_closed = is_closed
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(title: String, description: String, link: String, is_private: Bool, is_closed: Bool, completion: @escaping (Poll) -> ()) {
    guard let user = User.current else {
      print("No user is logged in!")
      return
    }
    let data: [String:Any] = ["user_id": user.id, "title": title, "description": description, "link": link, "private": is_private, "closed": is_closed]
    let colRef = FirebaseDataHandler.colRef(collection: .poll)
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let poll = Poll(id: documentId, user_id: user.id, title: title, description: description, link: link, is_private: is_private, is_closed: is_closed)
      completion(poll)
    })
  }
  
  static func withId(id: String, completion: @escaping (Poll?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let polls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
        completion(polls[0])
      }
    })
  }
  
  static func allPolls(completion: @escaping ([Poll]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allPolls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      completion(allPolls)
    })
  }
  
  func questions(completion: @escaping ([Question]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .question).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let questions: [Question] = ModelParser.parse(collection: .question, data: data) as! [Question]
      completion(questions)
    })
  }
  
  
  private func accumulateTags(tag: Tag, completion: @escaping ([Tag]) -> ()) {
    tagsFound.append(tag)
    if tagsFound.count == numTags! {
      completion(tagsFound)
    }
  }
  
  func tags(completion: @escaping ([Tag]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .polltag).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polltags: [PollTag] = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
      self.numTags = polltags.count
      self.tagsFound = []
      for polltag in polltags {
        let tagDocRef = FirebaseDataHandler.docRef(collection: .tag, documentId: polltag.tag_id)
        FirebaseDataHandler.get(docRef: tagDocRef, completion: { data in
          let singleTag: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
          self.accumulateTags(tag: singleTag[0], completion: completion)
        })
      }
    })
  }
  
  func addTags(tagNames: [String]) {
    // SECURITY: If Poll's owner is not current user, Do NOT let pass
    if User.current?.id != self.user_id {
      print("Current user is not the poll's owner!")
      return
    }
    
    for tagName in tagNames {
      let query = FirebaseDataHandler.colRef(collection: .tag).whereField("name", isEqualTo: tagName)
      FirebaseDataHandler.get(query: query, completion: { data in
        let tags: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
        // Add a new tag when no tag is found with the name
        if tags.isEmpty {
          Tag.create(name: tagName, completion: { tag in
            PollTag.create(poll_id: self.id, tag_id: tag.id, completion: { polltag in
              // There's nothing more to do after creating Tag and PollTag instances
            })
          })
        }
      })
    }
  }
  
  func likes(completion: @escaping ([Like]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .like).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
    let likes: [Like] = ModelParser.parse(collection: .like, data: data) as! [Like]
      completion(likes)
    })
  }
  
  func comments(completion: @escaping ([Comment]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .comment).whereField("poll_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
    let comments: [Comment] = ModelParser.parse(collection: .comment, data: data) as! [Comment]
      completion(comments)
    })
  }
  
  func user(completion: @escaping (User?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .user, documentId: user_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
      if (users.count > 0) {
        completion(users[0])
      } else {
        completion(nil)
      }
      
    })
  }
  
  func update(user_id: String?, title: String?, description: String?, link: String?, is_private: Bool?, completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: id)
    var data: [String:Any] = [:]
    if let user_id = user_id {
      data["user_id"] = user_id
      self.user_id = user_id
    }
    if let title = title {
      data["title"] = title
      self.title = title
    }
    if let description = description {
      data["description"] = description
      self.description = description
    }
    if let link = link {
      data["link"] = link
      self.link = link
    }
    if let is_private = is_private {
      data["private"] = is_private
      self.is_private = is_private
    }
    FirebaseDataHandler.update(docRef: docRef, data: data, completion: completion)
  }
  
  func delete(completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef, completion: completion)
  }
}
