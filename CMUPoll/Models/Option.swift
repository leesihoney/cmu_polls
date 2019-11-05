//
//  Option.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Option: Identifiable {
  var id: String
  var text: String
  var question_id: String
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, text: String, question_id: String) {
    self.id = id
    self.text = text
    self.question_id = question_id
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(text: String, question_id: String, completion: @escaping (Option) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .option)
    let data: [String:Any] = ["text": text, "question_id": question_id]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let option = Option(id: documentId, text: text, question_id: question_id)
      completion(option)
    })
  }
  
  func question(completion: @escaping (Question) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .question).whereField("id", isEqualTo: question_id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let questions: [Question] = ModelParser.parse(collection: .question, data: data) as! [Question]
      completion(questions[0])
    })
  }
  
  func answers(completion: @escaping ([Answer]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .answer).whereField("option_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let answers: [Answer] = ModelParser.parse(collection: .answer, data: data) as! [Answer]
      completion(answers)
    })
  }
}
