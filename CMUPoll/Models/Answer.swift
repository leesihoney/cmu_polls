//
//  Answer.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Answer: Identifiable {
  var id: String
  var user_id: String
  var question_id: String
  var option_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, user_id: String, question_id: String, option_id: String) {
    self.id = id
    self.user_id = user_id
    self.question_id = question_id
    self.option_id = option_id
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(question_id: String, option_id: String, completion: @escaping (Answer) -> ()) {
    guard let user = User.current else {
      print("No user is logged in!")
      return
    }
    let colRef = FirebaseDataHandler.colRef(collection: .answer)
    let data: [String:Any] = ["user_id": user.id, "question_id": question_id, "option_id": option_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let answer = Answer(id: documentId, user_id: user.id, question_id: question_id, option_id: option_id)
      completion(answer)
    })
  }
  
  static func withId(id: String, completion: @escaping (Answer?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .answer, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let answers: [Answer] = ModelParser.parse(collection: .answer, data: data) as! [Answer]
        completion(answers[0])
      }
    })
  }
  
  static func allAnswers(completion: @escaping ([Answer]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .answer)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allAnswers: [Answer] = ModelParser.parse(collection: .answer, data: data) as! [Answer]
      completion(allAnswers)
    })
  }
  
  func question(completion: @escaping (Question) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .question, documentId: question_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let questions: [Question] = ModelParser.parse(collection: .question, data: data) as! [Question]
      completion(questions[0])
    })
  }
  
  func option(completion: @escaping (Option) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .option, documentId: option_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let options: [Option] = ModelParser.parse(collection: .option, data: data) as! [Option]
      completion(options[0])
    })
  }
  
  func user(completion: @escaping (User) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .user, documentId: user_id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
      completion(users[0])
    })
  }
  
  mutating func update(user_id: String?, question_id: String?, option_id: String?) {
    let docRef = FirebaseDataHandler.docRef(collection: .answer, documentId: id)
    var data: [String:Any] = [:]
    if let user_id = user_id {
      data["user_id"] = user_id
      self.user_id = user_id
    }
    if let question_id = question_id {
      data["question_id"] = question_id
      self.question_id = question_id
    }
    if let option_id = option_id {
      data["option_id"] = option_id
      self.option_id = option_id
    }
    FirebaseDataHandler.update(docRef: docRef, data: data)
  }
}
