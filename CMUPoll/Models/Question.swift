//
//  Question.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Question: Identifiable {
  var id: String
  var is_multiple_choice: Bool
  var title: String
  var poll_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, is_multiple_choice: Bool, title: String, poll_id: String) {
    self.id = id
    self.is_multiple_choice = is_multiple_choice
    self.title = title
    self.poll_id = poll_id
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(is_multiple_choice: Bool, title: String, poll_id: String, completion: @escaping (Question) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .question)
    let data: [String:Any] = ["is_multiple_choice": is_multiple_choice, "title": title, "poll_id": poll_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let question = Question(id: documentId, is_multiple_choice: is_multiple_choice, title: title, poll_id: poll_id)
      completion(question)
    })
  }
  
  static func withId(id: String, completion: @escaping (Question?) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .question).whereField("id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let questions: [Question] = ModelParser.parse(collection: .question, data: data) as! [Question]
        completion(questions[0])
      }
    })
  }
  
  func options(completion: @escaping ([Option]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .option).whereField("question_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let options: [Option] = ModelParser.parse(collection: .option, data: data) as! [Option]
      completion(options)
    })
  }
  
  func answers(completion: @escaping ([Answer]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .answer).whereField("question_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let answers: [Answer] = ModelParser.parse(collection: .answer, data: data) as! [Answer]
      completion(answers)
    })
  }
  
  func poll(completion: @escaping (Poll) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("id", isEqualTo: poll_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      completion(polls[0])
    })
  }
  
  mutating func update(is_multiple_choice: Bool?, title: String?, poll_id: String?) {
    let docRef = FirebaseDataHandler.docRef(collection: .question, documentId: id)
    var data: [String:Any] = [:]
    if let is_multiple_choice = is_multiple_choice {
      data["is_multiple_choice"] = is_multiple_choice
      self.is_multiple_choice = is_multiple_choice
    }
    if let title = title {
      data["title"] = title
      self.title = title
    }
    if let poll_id = poll_id {
      data["poll_id"] = poll_id
      self.poll_id = poll_id
    }
    FirebaseDataHandler.update(docRef: docRef, data: data)
  }
  
  func delete() {
    let docRef = FirebaseDataHandler.docRef(collection: .question, documentId: id)
    FirebaseDataHandler.delete(docRef: docRef)
  }
}
