//
//  User.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import GoogleSignIn

class User: Identifiable {
  enum RewardType {
    case upload, answer, comment
  }
  var id: String
  var first_name: String
  var last_name: String
  var email: String
  var major: String
  var graduation_year: Int? = 2020
  var points: Int = 0
  
  // Used for double, triple query
  var pollIDsFound: [String] = []
  var numPollIDs: Int?
  var pollsFound: [Poll] = []
  var numPolls: Int?
  
  static var current: User?
  
  // NOTE: Used to initialize an instance that's already up on Firebase
  init (id: String, first_name: String, last_name: String, email: String, major: String, graduation_year: Int?, points: Int?) {
    self.id = id
    self.first_name = first_name
    self.last_name = last_name
    self.email = email
    self.major = major
    self.graduation_year = graduation_year
    if let points = points {
      self.points = points
    }
  }
  
  // NOTE: Used to initialize a completely new instance and to upload to Firebase
  static func create(first_name: String, last_name: String, email: String, major: String, graduation_year: Int?, completion: @escaping (User) -> ()) {
    let colRef = FirebaseDataHandler.colRef(collection: .user)
    let data: [String:Any] = ["first_name": first_name, "last_name": last_name, "email": email, "major": major, "graduation_year": graduation_year ?? "NULL", "points": 0]
    FirebaseDataHandler.add(colRef: colRef, data: data, completion: { documentId in
      let user = User(id: documentId, first_name: first_name, last_name: last_name, email: email, major: major, graduation_year: graduation_year, points: nil)
      completion(user)
    })
  }
  
  static func withId(id: String, completion: @escaping (User?) -> ()) {
    let docRef = FirebaseDataHandler.docRef(collection: .user, documentId: id)
    FirebaseDataHandler.get(docRef: docRef, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
        completion(users[0])
      }
    })
  }
  
  static func withEmail(email: String, completion: @escaping (User?) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .user).whereField("email", isEqualTo: email)
    FirebaseDataHandler.get(query: query, completion: { data in
      if data.isEmpty {
        completion(nil)
      } else {
        let users: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
        completion(users[0])
      }
    })
  }
  
  static func allUsers(completion: @escaping ([User]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .user)
    FirebaseDataHandler.get(query: query, completion: { data in
      let allUsers: [User] = ModelParser.parse(collection: .user, data: data) as! [User]
      completion(allUsers)
    })
  }
  
  private func reward(type: RewardType) -> Int {
    switch type {
    case .upload:
      return 10
    case .answer:
      return 5
    case .comment:
      return 5
    }
  }
  
  func addPoints(type: RewardType) {
    self.points += reward(type: type)
  }
  
  
  func polls(completion: @escaping ([Poll]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("user_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let polls: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
      completion(polls)
    })
  }
  
  private func accumulatePolls(poll: Poll, completion: @escaping ([Poll]) -> ()) {
    pollsFound.append(poll)
    // When done accumulating polls, sort the array and pass it to completion handler
    if pollsFound.count == numPolls! {
      let sorted = Poll.sort(pollsFound)
      completion(sorted)
    }
  }
  
  private func accumulatePollIDs(poll_id: String, completion: @escaping ([Poll]) -> ()) {
    pollIDsFound.append(poll_id)
    // When done accumulating poll_ids, start accumulating polls for each poll_id
    if pollIDsFound.count == numPollIDs! {
      let pollIDs = Set(pollIDsFound)
      numPolls = pollIDs.count
      pollsFound = []
      for poll_id in pollIDs {
        let docRef = FirebaseDataHandler.docRef(collection: .poll, documentId: poll_id)
        FirebaseDataHandler.get(docRef: docRef) { data in
          let singlePoll: [Poll] = ModelParser.parse(collection: .poll, data: data) as! [Poll]
          self.accumulatePolls(poll: singlePoll[0], completion: completion)
        }
      }
    }
  }
  
  func answeredPolls(completion: @escaping ([Poll]) -> ()) {
    // Find all answers and their question_ids for the current user
    let query = FirebaseDataHandler.colRef(collection: .answer).whereField("user_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query) { data in
      let answers: [Answer] = ModelParser.parse(collection: .answer, data: data) as! [Answer]
      let question_ids: [String] = answers.map { $0.question_id }
      // Accumulate all poll_ids for found question_ids
      self.numPollIDs = question_ids.count
      self.pollIDsFound = []
      for question_id in question_ids {
        let docRef = FirebaseDataHandler.docRef(collection: .question, documentId: question_id)
        FirebaseDataHandler.get(docRef: docRef) { data in
          let singleQuestion: [Question] = ModelParser.parse(collection: .question, data: data) as! [Question]
          let poll_id = singleQuestion[0].poll_id
          self.accumulatePollIDs(poll_id: poll_id, completion: completion)
        }
      }
    }
  }
  
  func likes(completion: @escaping ([Like]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .like).whereField("user_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let likes: [Like] = ModelParser.parse(collection: .like, data: data) as! [Like]
      completion(likes)
    })
  }
  
  func comments(completion: @escaping ([Comment]) -> ()) {
    let query = FirebaseDataHandler.colRef(collection: .comment).whereField("user_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let comments: [Comment] = ModelParser.parse(collection: .comment, data: data) as! [Comment]
      completion(comments)
    })
  }
  
  /* NOTE: Excluded in the testing,
  CMUPollTests Target cannot access the AppDelegate and CoreData */
  static func logout() {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    // Get CoreData context
    let context = delegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
    // Clear CoreData
    do {
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
      try context.execute(batchDeleteRequest)
    } catch {
      print("Detele all data error :", error)
    }
    
    User.current = nil
    GIDSignIn.sharedInstance()?.delegate = nil
    GIDSignIn.sharedInstance()?.signOut()
    GIDSignIn.sharedInstance()?.disconnect()
    if (delegate.uponLogOut != nil) {
      delegate.uponLogOut!()
    }
  }
  
  func update(major: String?, graduation_year: Int?, points: Int?, completion: @escaping () -> Void) {
    let docRef = FirebaseDataHandler.docRef(collection: .user, documentId: id)
    var data: [String:Any] = [:]
    if let major = major {
      data["major"] = major
      self.major = major
    }
    if let graduation_year = graduation_year {
      data["graduation_year"] = graduation_year
      self.graduation_year = graduation_year
    }
    if let points = points {
      data["points"] = points
      self.points = points
    }
    
    FirebaseDataHandler.update(docRef: docRef, data: data, completion: completion)
  }
}
