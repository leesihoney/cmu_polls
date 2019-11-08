//
//  Tag.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

class Tag: Identifiable, Hashable {
  
  var id: String
  var name: String
  
  // Used for double query
  var pollsFound: [Poll] = []
  var numPolls: Int?
  
  static var tagPopularity: [Tag:Int] = [:]
  static var numTags: Int?
  
  func hash(into hasher: inout Hasher) {
     hasher.combine(id)
     hasher.combine(name)
  }
  static func == (lhs: Tag, rhs: Tag) -> Bool {
    return lhs.id == rhs.id
  }
  static func < (lhs: Tag, rhs: Tag) -> Bool {
    return lhs.id.hashValue < rhs.id.hashValue
  }
  
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
  
  static func withId(id: String, completion: @escaping (Tag?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .tag, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let tags: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
        completion(tags[0])
      }
    })
  }
  
  private static func accumulateTagPopularity(tag: Tag, count: Int, completion: @escaping ([Tag]) -> ()) {
    tagPopularity[tag] = count
    
    if tagPopularity.count == numTags {
      // sort and call completion
      let sortedTagPopularity = tagPopularity.sorted(by: { $0.value > $1.value })
      var sortedTags: [Tag] = []
      for popularity in sortedTagPopularity {
        sortedTags.append(popularity.key)
      }
      completion(sortedTags)
    }
  }
  
  static func allTags(completion: @escaping ([Tag]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .tag)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allTags: [Tag] = ModelParser.parse(collection: .tag, data: data) as! [Tag]
      
      // Sort tags in popular order
      self.numTags = allTags.count
      for tag in allTags {
        let polltagQuery = FirebaseDataHandler.colRef(collection: .polltag).whereField("tag_id", isEqualTo: tag.id)
        FirebaseDataHandler.get(query: polltagQuery, completion: { data in
          let polltags: [PollTag] = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
          
          accumulateTagPopularity(tag: tag, count: polltags.count, completion: completion)
        })
      }
    })
  }
  
  private func accumulatePolls(poll: Poll, completion: @escaping ([Poll]) -> ()) {
    pollsFound.append(poll)
    if pollsFound.count == numPolls! {
      completion(pollsFound)
    }
  }
  
  func polls(completion: @escaping ([Poll]) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .polltag, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let polltags: [PollTag] = ModelParser.parse(collection: .polltag, data: data) as! [PollTag]
      self.numPolls = polltags.count
      self.pollsFound = []
      for polltag in polltags {
        let pollDocRef = FirebaseDataHandler.docRef(collection: .poll, documentId: polltag.poll_id)
        FirebaseDataHandler.get(docRef: pollDocRef, completion: { data in
          let singlePoll: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
          self.accumulatePolls(poll: singlePoll[0], completion: completion)
        })
      }
    })
  }
}
