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
  var posted_at: String
  var link: String
  var is_private: Bool
  var is_closed: Bool
  var passcode: String?
  
  // Used for double query
  var tagsFound: [Tag] = []
  var numTags: Int?
  static var pollsFound: [Poll] = []
  static var numPolls: Int?
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, user_id: String, title: String, description: String, posted_at: String, link: String, is_private: Bool, is_closed: Bool, passcode: String?) {
    self.id = id
    self.user_id = user_id
    self.title = title
    self.description = description
    self.posted_at = posted_at
    self.link = link
    self.is_private = is_private
    self.is_closed = is_closed
    self.passcode = passcode
  }
  
  static func sort(_ polls: [Poll]) -> [Poll] {
    var polls = polls
    polls.sort(by: { p1, p2 in
      return getDate(p1.posted_at) < getDate(p2.posted_at)
    })
    return polls
  }
  
  private static func getDateString() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: date)
  }
  
  private static func getDate(_ dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: dateString)!
  }
  
  func getDateDisplayString() -> String {
    let date = Poll.getDate(self.posted_at)
    
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter.localizedString(for: date, relativeTo: Date())
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(title: String, description: String, link: String, is_private: Bool, is_closed: Bool, passcode: String?, completion: @escaping (Poll) -> ()) {
    guard let user = User.current else {
      print("No user is logged in!")
      return
    }
    let posted_at: String = getDateString()
    let data: [String:Any] = ["user_id": user.id, "title": title, "description": description, "posted_at": posted_at, "link": link, "private": is_private, "closed": is_closed, "passcode": passcode ?? "NULL"]
    let colRef = FirebaseDataHandler.colRef(collection: .poll)
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let poll = Poll(id: documentId, user_id: user.id, title: title, description: description, posted_at: posted_at, link: link, is_private: is_private, is_closed: is_closed, passcode: passcode)
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
  
  private static func accumulatePolls(poll: Poll, completion: @escaping ([Poll]) -> ()) {
    pollsFound.append(poll)
    if pollsFound.count == numPolls! {
      let sorted = Poll.sort(pollsFound)
      completion(sorted)
    }
  }
  
  static func withTag(name: String, completion: @escaping ([Poll]) -> ()) {
    // Find a Tag with a given name
    let tagQuery = FirebaseDataHandler.colRef(collection: .tag)
      .whereField("name", isEqualTo: name)
    FirebaseDataHandler.get(query: tagQuery, completion: { data in
      if data.isEmpty {
        completion([])
      }
      let singleTag: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
      // Find PollTags associated with found Tag
      let polltagQuery = FirebaseDataHandler.colRef(collection: .polltag)
        .whereField("tag_id", isEqualTo: singleTag[0].id)
      FirebaseDataHandler.get(query: polltagQuery, completion: { data in
        if data.isEmpty {
          completion([])
        }
        // Find Polls associated with found polltags
        let polltags: [PollTag] = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
        self.numPolls = polltags.count
        self.pollsFound = []
        for polltag in polltags {
          let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: polltag.poll_id)
          FirebaseDataHandler.get(docRef: docRef, completion: { data in
            let singlePoll: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
            self.accumulatePolls(poll: singlePoll[0], completion: completion)
          })
        }
      })
    })
  }
  
  static func allPolls(completion: @escaping ([Poll]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll)
      .order(by: "posted_at", descending: true)
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
      if data.isEmpty {
        completion([])
      }
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
  
  func update(user_id: String?, title: String?, description: String?, link: String?, is_private: Bool?, passcode: String?, completion: @escaping () -> Void) {
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
    if let passcode = passcode {
      data["passcode"] = passcode
      self.passcode = passcode
    }
    FirebaseDataHandler.update(docRef: docRef, data: data, completion: completion)
  }
  
  func delete(completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef, completion: completion)
  }
}
